# Get the resolved URL from a FossHub download link.
#
# Takes a FossHub URL and returns the generated
# expiring download link for the file.
#
# Usage: Get-UrlFromFosshub url
# Example:
# Get-UrlFromFosshub https://www.fosshub.com/Audacity.html/audacity-win-2.1.2.exe

Function get-UrlFromFosshub($linkUrl) {

  $fosshubAppName = $linkUrl -match 'fosshub.com/(.*)/(.*)'
  # If there’s no match, it means that it’s not a FossHub URL.
  # Then this function simply returns the input URL.
  if (!$Matches) {
    return $linkUrl
  }

  # Get the actual FossHub appname from the matches array
  # From the example above, this would be Audacity.html
  $fosshubAppName = $Matches[1]

  # Get the file name from the URL
  # From the example above, this would be audacity-win-2.1.2.exe
  $fosshubFileName = $Matches[2]

  # Create the contents of the href that is being searched for
  # From the example above, this would be /Audacity.html/audacity-win-2.1.2.exe
  $hrefText = "/$fosshubAppName/$fosshubFileName"

  # Construct the Regular Expression pattern.  An example of what is being searched for is this
  # <a href="/Audacity.html/audacity-win-2.1.2.exe" rel="nofollow" class="dwl-link xlink" file="audacity-win-2.1.2.exe" xdts="https://download.fosshub.com/Protected/expiretime=1480500963;badurl=aHR0cDovL3d3dy5mb3NzaHViLmNvbS9BdWRhY2l0eS5odG1s/5cd3862bc6dd39508c537b1ad21a0bdc2e7d46dd4c64d182cfb6a819d0ef20a1/Audacity/audacity-win-2.1.2.exe">
  $regexPattern = "<a href=`"$hrefText`"[^>]+=`"(https:\/\/download\.fosshub\.com\/[^`"]+)`""

  $opts = @{ Headers = @{ Referer = "https://www.fosshub.com/${fosshubAppName}" } }
  $htmlPage = Get-WebContent -url $linkUrl -options $opts 2>$null

  $dataLink = $htmlPage -match $regexPattern

  if (!$Matches) {
    return $linkUrl
  }

  return $Matches[1]
}
