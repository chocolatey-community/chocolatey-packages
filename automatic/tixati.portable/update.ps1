import-module au

$releases = 'https://www.tixati.com/download/portable.html'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $url32 = $download_page.links | ? href -match '\.zip$' | % href
    $url32 -match '(?<=tixati-).+?(?=\.portable)'
    $version = $Matches[0] -replace '-.+'

    @{ URL32 = $url32;  Version = $version }
}

update -ChecksumFor 32
