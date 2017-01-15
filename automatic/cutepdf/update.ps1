import-module au

$download_page_url = 'http://www.cutepdf.com/Products/CutePDF/writer.asp'
$url = 'http://www.cutepdf.com/download/CuteWriter.exe'

function global:au_SearchReplace {
	@{
		'tools\ChocolateyInstall.ps1' = @{
			"(^[$]checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL)'"
		}
	 }
}

function global:au_GetLatest {
	$page = Invoke-WebRequest $download_page_url
	$html = $page.parsedHTML

	$download_link = $html.body.getElementsByTagName("a") | where {$_.href -like "*../../download/CuteWriter.exe"}  | Select-Object -first 1
	$version_row = $download_link.parentElement.parentElement.nextSibling.outerHTML
	$version = $version_row.SubString($version_row.IndexOf("(Ver. "), $version_row.LastIndexOf(";") - $version_row.IndexOf("(Ver. ")).Replace("(Ver. ","")

	return @{ URL = $url; Version = $version }
}

update -NoCheckUrl -ChecksumFor 32
