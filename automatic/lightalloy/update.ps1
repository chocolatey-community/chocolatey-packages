import-module au
import-module .\..\..\extensions\chocolatey-fosshub.extension\extensions\Get-UrlFromFosshub.psm1

$releases = 'http://www.light-alloy.ru/download/'

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

    $result = $download_page.Content -match "<b>Light Alloy (.*) \(build"

    if (!$Matches) {
      throw "Light Alloy version not found on $releases"
    }

    $version = $Matches[1]
    $url32   = 'https://www.fosshub.com/Light-Alloy.html/LA_Setup_v<version>.exe'
    $url32   = $url32 -replace '<version>', $version

    return @{ URL32 = $url32; Version = $version }
}

update -NoCheckUrl -ChecksumFor 32
