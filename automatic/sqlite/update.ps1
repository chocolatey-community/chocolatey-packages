import-module au

$releases = 'https://sqlite.org/download.html'

function global:au_SearchReplace {
   @{
        ".\legal\VERIFICATION.txt" = @{
          "(?<=x32:\s).*"             = "$($Latest.URL32)"
          "(?<=\sx64:\s).*"           = "$($Latest.URL64)"
          "(?<=\sToolsx64:\s).*"      = "$($Latest.URLTools64)"
          "(?<=checksum32:).*"        = "$($Latest.Checksum32)"
          "(?<=checksum64:).*"        = "$($Latest.Checksum64)"
          "(?<=checksumTools64:\s).*" = "$($Latest.ChecksumTools64)"
        }
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
    $tools_name = $Latest.URLTools64 -split '/' | Select-Object -Last 1
    Invoke-WebRequest $Latest.URLTools64 -OutFile tools\$tools_name
    $Latest.ChecksumTools64 = Get-FileHash tools\$tools_name | ForEach-Object Hash
}

function global:au_GetLatest {
    function get_version( [int]$Bit=32 ) {
        $re = '(?<=,)(?<Version>.+),(?<Filename>\d*\/sqlite-dll-win-x{0}.+\.zip)' -f ((86, $Bit)[!($Bit -eq 32)])
        $download_page.Content -match $re | Out-Null
        $Matches.Version
    }

    function url_exists( [string] $Url ) {
        try { ([System.Net.WebRequest]::Create($Url)).GetResponse().Close(); return $true } catch { return $false }
    }

    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $version32 = get_version 32
    $version64 = get_version 64

    $re   = '(?<=,)\d{4}/sqlite-.+-win-x\d{2}-\d{7}\.zip'
    $urls = $download_page.Content | Select-String -Pattern $re -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { 'https://sqlite.org/' + $_.Groups[0].Value}
    $url32      = $urls -like '*dll*win-x86*'  | Select-Object -First 1
    $url64      = $urls -like '*dll*win-x64*'  | Select-Object -First 1
    $urlTools64 = $urls -like '*tools*win-x64*'| Select-Object -First 1

    # https://github.com/chocolatey/chocolatey-coreteampackages/issues/733
    if ($version32 -eq $version64) { $Version = $version32 }
    else {

        $u32 = $url64 -replace 'win-x64', 'win-x86'
        $u64 = $url64 -replace 'win-x86', 'win-x64'

        if (url_exists $u32)    { $Version = $version64; $url32 = $u32 }
        elseif (url_exists $64) { $Version = $version32; $url64 = $u64 }
        else {
            Write-Host "Can't find common version for x32 and x64 architecture."
            return 'ignore'
        }
    }

    @{ Version = $version; URL32 = $url32; URL64 = $url64; URLTools64 = $urlTools64; PackageName = 'SQLite' }
}

update -ChecksumFor none
