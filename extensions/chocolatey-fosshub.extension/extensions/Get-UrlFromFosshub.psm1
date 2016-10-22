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

  $referer = "https://www.fosshub.com/${fosshubAppName}"
  $webClient = Get-Downloader $linkUrl $referer

  $htmlPage = $webClient.DownloadString($linkUrl)

  $dataLink = $htmlPage -match $regexPattern

  if (!$Matches) {
    return $linkUrl
  }

  return $Matches[1]
}

function Get-Downloader {
param (
  [string]$url,
  [string]$referer
 )

  $downloader = new-object System.Net.WebClient
  $downloader.Headers.Add("Referer", $referer)

  $defaultCreds = [System.Net.CredentialCache]::DefaultCredentials
  if ($defaultCreds -ne $null) {
    $downloader.Credentials = $defaultCreds
  }

  $ignoreProxy = $env:chocolateyIgnoreProxy
  if ($ignoreProxy -ne $null -and $ignoreProxy -eq 'true') {
    Write-Debug "Explicitly bypassing proxy due to user environment variable"
    $downloader.Proxy = [System.Net.GlobalProxySelection]::GetEmptyWebProxy()
  } else {
    # check if a proxy is required
    $explicitProxy = $env:chocolateyProxyLocation
    $explicitProxyUser = $env:chocolateyProxyUser
    $explicitProxyPassword = $env:chocolateyProxyPassword
    if ($explicitProxy -ne $null -and $explicitProxy -ne '') {
      # explicit proxy
      $proxy = New-Object System.Net.WebProxy($explicitProxy, $true)
      if ($explicitProxyPassword -ne $null -and $explicitProxyPassword -ne '') {
        $passwd = ConvertTo-SecureString $explicitProxyPassword -AsPlainText -Force
        $proxy.Credentials = New-Object System.Management.Automation.PSCredential ($explicitProxyUser, $passwd)
      }

      Write-Debug "Using explicit proxy server '$explicitProxy'."
      $downloader.Proxy = $proxy

    } elseif (!$downloader.Proxy.IsBypassed($url)) {
      # system proxy (pass through)
      $creds = $defaultCreds
      if ($creds -eq $null) {
        Write-Debug "Default credentials were null. Attempting backup method"
        $cred = get-credential
        $creds = $cred.GetNetworkCredential();
      }

      $proxyaddress = $downloader.Proxy.GetProxy($url).Authority
      Write-Debug "Using system proxy server '$proxyaddress'."
      $proxy = New-Object System.Net.WebProxy($proxyaddress)
      $proxy.Credentials = $creds
      $downloader.Proxy = $proxy
    }
  }

  return $downloader
}