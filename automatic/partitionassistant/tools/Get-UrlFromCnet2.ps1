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
# @edit 2014-08-19

function Get-UrlFromCnet {
	param(
		[string]$srcUrl, 
		[string]$regex
	)

	try {
		# $srcUrl	= 'http://www.disk-partition.com/download-home.html'
		# $regex	= '(?ms).*href="(http://download.cnet.com/.+?)".*'
		
		$wc = New-Object system.Net.WebClient; 

		Write-Output "Searching for CNET link...";
		$html = $wc.downloadString($srcUrl);
		$url = $html -replace $regex, '$1';
		$html = $wc.downloadString($url);
		
		Write-Output "Searching through CNET html for links, this might take a few seconds...";

		$html -match "(?ms)data-dl-url=['`\`"](.+?)['`\`" ]+data-nodlm-url"

		# The regex misses the last quote. Seriously?
		# Also, the quotes seem to switch from single to double.
		
		Write-Output "Found link.";
		$url = $matches[1] -replace "'","" -replace '"',''

#		Secondary follow seems unnecessary
#		$html = $wc.downloadString($url);
#		Write-Output "Searching through CNET html for links (2)...";
#		
#		$url = $html -match '(?ms)HTTP-EQUIV="Refresh" CONTENT="0; URL=(http.*?)"/>', '$1';

		Remove-Variable matches
		
		return [string]$url		
	} catch {
		$errorMessage = "Could not resolve CNET host. Wrong regex, or source page changed, or CNET changed."
		Write-Error $errorMessage
		throw $errorMessage
  }
}
