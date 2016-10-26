import-module au

$releases = 'https://www.tixati.com/download/'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
            "(?i)(^[$]fileName\s*=\s*)('.*')"   = "`$1'$($Latest.FileName)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri "${releases}windows.html" -UseBasicParsing
    $url32 = $download_page.links | ? href -match '\.exe$' | select -First 1 | % href

    $download_page = Invoke-WebRequest -Uri "${releases}windows64.html" -UseBasicParsing
    $url64 = $download_page.links | ? href -match '\.exe$' | select -First 1 | % href

    $url64 -match '(?<=tixati-).+?(?=\.win64)'
    $version = $Matches[0] -replace '-.+$'

    $fileName = (Split-Path $url64 -Leaf) -replace 'win64-'

    @{ URL32 = $url32; URL64 = $url64; Version = $version; FileName = $fileName }
}

update
