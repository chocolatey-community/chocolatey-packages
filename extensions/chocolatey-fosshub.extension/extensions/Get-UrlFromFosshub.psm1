# Get the resolved URL from a FossHub download link.
#
# Takes a FossHub URL and returns the generated
# expiring download link for the file.
#
# Usage: Get-UrlFromFosshub url
# Example:
# Get-UrlFromFosshub https://www.fosshub.com/Audacity.html/audacity-win-2.1.2.exe

Function Get-UrlFromFosshub($linkUrl) {

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
  # <a href="/Audacity.html/audacity-win-2.1.2.exe" rel="nofollow" class="dwl-link xlink" file="audacity-win-2.1.2.exe" data="https://download.fosshub.com/Protected/expiretime=1475696791;badurl=aHR0cDovL3d3dy5mb3NzaHViLmNvbS9BdWRhY2l0eS5odG1s/606878a89d0b1e2bf998e0482bf081a451e8d98479d8b246a83d33db1a597538/Audacity/audacity-win-2.1.2.exe">
  $regexPattern = "<a href=`"$hrefText`".*data=`"(.*)`""

  $opts = @{ Headers = @{ Referer = 'https://www.fosshub.com/${fosshubAppName}' } }
  $htmlPage = Get-WebContent -url "http://example.com" -options $opts

  $dataLink = $htmlPage -match $regexPattern

  if (!$Matches) {
    return $linkUrl
  }

  return $Matches[1]
}

Export-ModuleMember -Function Get-UrlFromFosshub
