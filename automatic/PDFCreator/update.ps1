import-module au

$url = 'http://download.pdfforge.org/download/pdfcreator/PDFCreator-stable?download'
$download_page_url = 'http://www.pdfforge.org/pdfcreator/download'

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
        }
     }
}

function global:au_GetLatest {
    Write-Host $download_page_url

    $page = Invoke-WebRequest $download_page_url
	$html = $page.parsedHTML

    $current_item = $html.body.getElementsByTagName("div") | where {$_.className -like "*pdf-select-current*"}
    $header = $current_item.getElementsByTagName("h2") | where {$_.innerText -like "PDFCreator *"}
    $version = $header.innerText.Replace("PDFCreator ", "")
    $version_segments = $version.Split('.')

    if ($version_segments.length -eq 2) {
        $version = $version + ".0"
    }

    Write-Host $version

    return @{ URL = $url; Version = $version }
}

update -NoCheckUrl -ChecksumFor 32