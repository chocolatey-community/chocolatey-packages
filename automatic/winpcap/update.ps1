import-module au
import-module $PSScriptRoot\..\..\extensions\chocolatey-core.extension\extensions\chocolatey-core.psm1

$releases = 'https://www.winpcap.org/install/'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re      = '\.exe$'
    $url     = $download_page.links | ? href -match $re | select -First 1 -expand href
    $version = $url  -split 'WinPcap_|\.exe' | select -Last 1 -Skip 1
    @{
        Version      = $version.Replace('_', '.')
        URL32        = $releases + $url
        PackageName  = 'WinPcap'
    }
}

update -ChecksumFor 32
