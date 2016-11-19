import-module au
import-module .\..\..\extensions\extensions.psm1

$releases = 'https://www.fosshub.com/MKVToolNix.html'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]packageName\s*=\s*)('.*')"= "`$1'$($Latest.PackageName)'"
            "(^[$]url32\s*=\s*Get-UrlFromFosshub\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]url64\s*=\s*Get-UrlFromFosshub\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $result = $download_page.Content -match "mkvtoolnix-64bit-([\d\.]+)-setup.exe"

    if (!$Matches) {
      throw "mkvtoolnix version not found on $releases"
    }

    $version = $Matches[1]
    $url32   = 'https://www.fosshub.com/MKVToolNix.html/mkvtoolnix-32bit-<version>-setup.exe'
    $url64   = 'https://www.fosshub.com/MKVToolNix.html/mkvtoolnix-64bit-<version>-setup.exe'
    $url32   = $url32 -replace '<version>', $version
    $url64   = $url64 -replace '<version>', $version

    return @{ URL32 = $url32; URL64 = $url64; Version = $version }
}

update -NoCheckUrl
