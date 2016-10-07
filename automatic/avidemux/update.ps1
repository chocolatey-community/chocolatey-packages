import-module au
import-module .\..\..\extensions\chocolatey-fosshub.extension\extensions\Get-UrlFromFosshub.psm1

$releases = 'https://www.fosshub.com/Avidemux.html'

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

    $result = $download_page.Content -match "avidemux_([\d\.]+)_win32.exe"

    if (!$Matches) {
      throw "Avidemux version not found on $releases"
    }

    $version = $Matches[1]
    $url32   = 'https://www.fosshub.com/Avidemux.html/avidemux_<version>_win32.exe'
    $url64   = 'https://www.fosshub.com/Avidemux.html/avidemux_<version>_win64.exe'
    $url32   = $url32 -replace '<version>', $version
    $url64   = $url64 -replace '<version>', $version

    return @{ URL32 = $url32; URL64 = $url64; Version = $version }
}

update -NoCheckUrl
