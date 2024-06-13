Import-Module Chocolatey-AU

$releases = 'https://sqlite.org/download.html'

function global:au_SearchReplace {
   @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(\s+Toolsx64:).*"       = "`${1} $($Latest.URLTools64)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
          "(?i)(checksumTools64:).*"   = "`${1} $($Latest.ChecksumTools64)"
        }
        ".\tools\chocolateyInstall.ps1" = @{
          "sqlite-dll-win-x86.+\.zip" = "$($Latest.Filename32)"
          "sqlite-dll-win-x64.+\.zip" = "$($Latest.Filename64)"
          "sqlite-tools-win-x.+\.zip" = "$($Latest.FilenameTools64)"
        }
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
    $tools_name = $Latest.URLTools64 -split '/' | Select-Object -Last 1
    Invoke-WebRequest $Latest.URLTools64 -OutFile tools\$tools_name
    $Latest.FilenameTools64 = $tools_name
    $Latest.ChecksumTools64 = Get-FileHash tools\$tools_name | ForEach-Object Hash
}

function global:au_GetLatest {
    function get_version( [int]$Bit=32 ) {
        $version = $download_page.AllElements | Where-Object tagName -eq 'td' | Where-Object InnerHtml -match "$Bit-bit DLL .+ for SQLite version" | ForEach-Object InnerHtml
        $version -match '((?:\d+\.)+)' | out-null
        $Matches[0] -replace '\.$'
    }

    function url_exists( [string] $Url ) {
        try {
            ([System.Net.WebRequest]::Create($Url)).GetResponse().Close()
            return $true
        } catch {
            return $false
        }
    }

    $download_page = Invoke-WebRequest -Uri $releases
    $version32 = get_version 32
    $version64 = get_version 64

    $re   = '\-win-x\d\d\-.+\.zip'
    $urls = $download_page.links | Where-Object href -match $re | ForEach-Object { 'https://sqlite.org/' + $_.href }
    $url32      = $urls -like '*dll*win-x86*'   | Select-Object -First 1
    $url64      = $urls -like '*dll*win-x64*'   | Select-Object -First 1
    $urlTools64 = $urls -like '*tools*win-x64*' | Select-Object -First 1

    # https://github.com/chocolatey/chocolatey-coreteampackages/issues/733
    if ($version32 -eq $version64) {
        $Version = $version32
    } else {
        $u32 = $url64 -replace 'win-x64', 'win-x86'
        $u64 = $url64 -replace 'win-x86', 'win-x64'

        if (url_exists $u32) {
            $version = $version64
            $url32   = $u32
        } elseif (url_exists $64) {
            $version = $version32
            $url64   = $u64
        } else {
            Write-Host "Can't find common version for x32 and x64 architecture."
            return 'ignore'
        }
    }

    @{
      Version     = $version
      URL32       = $url32
      URL64       = $url64
      URLTools64  = $urlTools64
      PackageName = 'SQLite'
    }
}

update -ChecksumFor none
