import-module au

$download_page_url = 'http://download.pdfforge.org/download/pdfcreator/list'

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
     }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest $download_page_url
	$html = $page.parsedHTML

    $newest_release = $html.body.getElementsByTagName("td") | where {$_.className -like "*colrelease*" -and $_.innerText -notlike "*nightly*"} | Select-Object -first 1
    $version = $newest_release.innerText.Replace("PDFCreator ", "").Trim()

    $newest_release_url = $html.body.getElementsByTagName("a") | where {$_.href -like "*/download/pdfcreator/$version*"}

    $url = $newest_release_url.href.Replace("about:/download", "http://orange.download.pdfforge.org") + "&download"

    return @{ URL = $url; Version = $version }
}

update -NoCheckUrl -ChecksumFor 32