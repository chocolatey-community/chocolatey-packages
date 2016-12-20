import-module au

$releases = 'http://download.calibre-ebook.com/2.html'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^\s*packageName\s*=\s*)('.*')"= "`$1'$($Latest.PackageName)'"
            "(^\s*url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^\s*url64Bit\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $versionHyperlink = $download_page.links | select -First 1
    if ($versionHyperlink.Title -notmatch 'Release (2[\d\.]+)' ) { throw "Calibre version 2.x not found on $releases" }

    $version = $versionHyperlink.InnerText
    $url32   = 'https://download.calibre-ebook.com/<version>/calibre-<version>.msi'
    $url64   = 'https://download.calibre-ebook.com/<version>/calibre-64bit-<version>.msi'

    $url32   = $url32 -replace '<version>', $version
    $url64   = $url64 -replace '<version>', $version

    return @{ URL32 = $url32; URL64 = $url64; Version = $version }
}

update
