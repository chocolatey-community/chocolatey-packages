# Get the resolved URL form a CNET download link.
# The initial link to CNET on a software source page changes, so we need the URL to the source page and a REGEX that will return the CNET url.
# We want to specify only a search parameter that will replace the entire document with just the url - to keep things easy.
# This function will return the actual downloadable URL.
#
# Usage: Get-UrlFromCnet download_page regex
# Examples:
# Get-FilenameFromRegex $url '(?ms).*href="(http://download.cnet.com/.+?)".*'
#
# @author Redsandro
# @edit 2013-11-19

function Get-UrlFromCnet {
	param(
		[string]$srcUrl, 
		[string]$regex
	)

	try {
	
		$wc = New-Object system.Net.WebClient;

		Write-Host "Getting download link...";
		$html = $wc.downloadString($srcUrl);
		$url = $html -replace $regex, '$1';
		$html = $wc.downloadString($url);
		
		Write-Host "Searching through CNET html for links, this might take a few seconds...";
		# THIS ONE IS SLOW. Someone improve please. :)
		$url = $html -replace '(?ms).*<a href="(.+?)".*?Download Now.*', '$1';
		$html = $wc.downloadString($url);
		$url = $html -replace '(?ms).*HTTP-EQUIV="Refresh" CONTENT="0; URL=(http.*?)"/>.*', '$1';
	
		return $url
		
	} catch {
		$errorMessage = "Could not resolve CNET host. Wrong regex, or source page changed, or CNET changed."
		Write-Error $errorMessage
		throw $errorMessage
  }
}
