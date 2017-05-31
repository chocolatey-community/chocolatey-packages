import-module au
cd "$PSScriptRoot"

$domain            = 'http://download.pdfforge.org'
$download_page_url = "$domain/download/pdfcreator/list"

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
     }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest $download_page_url -UseBasicParsing

    $latestUrl = $page.Links | ? href -match 'Setup\.exe' | select -first 1 -expand href
    if ($latestUrl.StartsWith('/')) {
      $latestUrl = $domain + $latestUrl
    }
    $latestUrl += '&download'

    $version = $latestUrl -split '/' | select -last 1 -skip 1

    return @{ URL = $latestUrl; Version = $version; PackageName = 'PDFCreator' }
}

update -ChecksumFor 32
