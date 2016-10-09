import-module au

$releases = 'http://get.geo.opera.com/pub/opera/desktop/'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]version\s*=\s*)('.*')"    = "`$1'$($Latest.Version)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $versionLink     = $download_page.links | select -Last 1

    $version = $versionLink.href -replace '/', ''

    $url32   = 'http://get.geo.opera.com/pub/opera/desktop/<version>/win/Opera_<version>_Setup.exe'
    $url32   = $url32 -replace '<version>', $version

    return @{ URL32 = $url32; Version = $version }
}

update -ChecksumFor 32
