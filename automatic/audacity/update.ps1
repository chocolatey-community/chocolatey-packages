import-module au
import-module .\..\..\extensions\extensions.psm1

$releases = 'http://www.audacityteam.org/download/windows/'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]packageName\s*=\s*)('.*')"= "`$1'$($Latest.PackageName)'"
            "(^[$]url32\s*=\s*Get-UrlFromFosshub\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re      = '.exe'
    $url     = $download_page.links | ? href -match $re | select -First 1
    if ($url.InnerText -notmatch 'Audacity (2[\d\.]+) installer' ) { throw "Audacity version 2.x not found on $releases" }

    $url32   = $url.href
    $version = $url32 -split '-|.exe' | select -Last 1 -Skip 1

    return @{ URL32 = $url32; Version = $version }
}

update -NoCheckUrl -ChecksumFor 32
