import-module au

$releases = 'https://sqlite.org/download.html'

function global:au_SearchReplace {
   @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(\s+Toolsx32:).*"       = "`${1} $($Latest.URLTools32)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
          "(?i)(checksumTools32:).*"   = "`${1} $($Latest.ChecksumTools32)"
        }
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
    $tools_name = $Latest.URLTools32 -split '/' | select -Last 1
    iwr $Latest.URLTools32 -OutFile tools\$tools_name
    $Latest.ChecksumTools32 = Get-FileHash tools\$tools_name | % Hash
}

function global:au_GetLatest {
    function get_version( [int]$Bit=32 ) {
        $version = $download_page.AllElements | ? tagName -eq 'td' | ? InnerHtml -match "$Bit-bit DLL .+ for SQLite version" | % InnerHtml
        $version -match '((?:\d+\.)+)' | out-null
        $Matches[0] -replace '\.$'
    }

    function url_exists( [string] $Url ) {
        try { ([System.Net.WebRequest]::Create($Url)).GetResponse().Close(); return $true } catch { return $false }
    }

    $download_page = Invoke-WebRequest -Uri $releases
    $version32 = get_version 32
    $version64 = get_version 64

    $re  = '\-win\d\d\-.+\.zip'
    $url = $download_page.links | ? href -match $re | % { 'https://sqlite.org/' + $_.href }
    $url32      = $url -like '*dll*win32*' | select -First 1
    $url64      = $url -like '*dll*win64*' | select -First 1
    $urlTools32 = $url -like '*tools*win32*'| select -First 1

    # https://github.com/chocolatey/chocolatey-coreteampackages/issues/733
    if ($version32 -eq $version64) { $Version = $version32 }
    else {

        $u32 = $url64 -replace 'win64', 'win32'
        $u64 = $url64 -replace 'win32', 'win64'

        if (url_exists $u32)    { $Version = $version64; $url32 = $u32 }
        elseif (url_exists $64) { $Version = $version32; $url64 = $u64 }
        else {
            Write-Host "Can't find common version for x32 and x64 architecture."
            return 'ignore'
        }
    }

    @{ Version = $version; URL32 = $url32; URL64 = $url64; URLTools32 = $urlTools32; PackageName = 'SQLite' }
}

update -ChecksumFor none
