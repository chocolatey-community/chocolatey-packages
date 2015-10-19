# Takes a fosshub link in the “genLink” format and returns
# the generated expiring download link for the file,
# which can be used for downloading with Ketarin/Chocolatey
Function Get-FosshubLinks($genLinkUrl) {

  $fosshubAppName = $genLinkUrl -match 'genLink/(.+?)/'
  $fosshubAppName = $Matches[1]

  $referer = "http://www.fosshub.com/${fosshubAppName}.html"

  $webClient = New-Object System.Net.WebClient
  $webClient.Headers.Add("Referer", $referer)

  $generatedLink = $webClient.DownloadString($genLinkUrl)

  return $generatedLink
}
