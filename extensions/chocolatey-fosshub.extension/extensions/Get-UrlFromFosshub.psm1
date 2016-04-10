# Get the resolved URL form a FossHub download link.
#
# Takes a FossHub URL in the “genLink” format and returns the generated
# expiring download link for the file.
#
# Usage: Get-UrlFromFosshub genLink_url
# Example:
# Get-UrlFromFosshub http://www.fosshub.com/genLink/Data-Crow/FILE.zip

Function Get-UrlFromFosshub($genLinkUrl) {

  $fosshubAppName = $genLinkUrl -match 'genLink/(.+?)/'
  # If there’s no match, it means that it’s not a FossHub genLink URL.
  # Then this function simply returns the input URL.
  if (!$Matches) {
    return $genLinkUrl
  }
  # Get the actual FossHub appname from the matches array
  $fosshubAppName = $Matches[1]

  $referer = "http://www.fosshub.com/${fosshubAppName}.html"
  $webClient = New-Object System.Net.WebClient
  $webClient.Headers.Add("Referer", $referer)

  $generatedLink = $webClient.DownloadString($genLinkUrl)

  return $generatedLink
}