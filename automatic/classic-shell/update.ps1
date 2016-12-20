import-module au

$releases = 'http://www.classicshell.net/'

function global:au_SearchReplace {
   @{
        ".\tools\ChocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re      = '.exe'
    $url     = $download_page.links | ? href -match $re | select -skip 1 | select -First 1
    if ($url.Title -notmatch 'Download latest version ([\d\.]+)' ) { throw "classic-shell version not found on $releases" }

    $url32   = $url.href

    $version     = $download_page.links | ? href -match $re | select -First 1
    $version = $version.InnerHTML

    return @{ URL32 = $url32; Version = $version }
}

update -ChecksumFor 32
