Function Get-FosshubWebFile() {
<#
.SYNOPSIS
Downloads a file from fosshub

.DESCRIPTION
This will download a file from fosshub from the specified url.

.NOTES
This is mostly a copy of the Official Get-ChocolateyWebFile with functionality not
compatible with fosshub removed, and functionality needed for fosshub added.

.EXAMPLE
# Minimal Example
Get-FosshubWebFile -PackageName 'mypackage' -Url 'https://www.fosshub.com/mypackage.html/mypackage_0.1.0.exe'
#>
  param(
    [parameter(Mandatory=$true, Position=0)][string] $packageName,
    [parameter(Mandatory=$false, Position=2)][string] $url = '',
    [parameter(Mandatory=$false, Position=3)]
    [alias("url64")][string] $url64bit = $url,
    [parameter(Mandatory=$false)][string] $checksum = '',
    [parameter(Mandatory=$false)][string] $checksumType = '',
    [parameter(Mandatory=$false)][string] $checksum64 = $checksum,
    [parameter(Mandatory=$false)][string] $checksumType64 = $checksumType,
    [parameter(Mandatory=$false)][hashtable] $options = @{Headers=@{}},
    [parameter(Mandatory=$false)][switch] $forceDownload,
    [parameter(ValueFromRemainingArguments = $true)][Object[]] $ignoredArguments
  )

  Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

  if ($url -ne $null) { $url = $url.Replace('//', '/').Replace(':/', '://') }
  if ($url64bit -ne $null) { $url64bit = $url64bit.Replace('//', '/').Replace(':/', '://') }

  $url32bit = $url

  # allow user provided values for checksumming
  $checksum32Override = $env:chocolateyChecksum32
  $checksumType32Override = $env:chocolateyChecksumType32
  $checksum64Override = $env:chocolateyChecksum64
  $checksumType64Override = $env:chocolateyChecksumType64
  if ($checksum32Override -ne $null -and $checksum32Override -ne '') { $checksum = $checksum32Override }
  if ($checksumType32Override -ne $null -and $checksumType32Override -ne '') { $checksumType = $checksumType32Override }
  if ($checksum64Override -ne $null -and $checksum64Override -ne '') { $checksum64 = $checksum64Override }
  if ($checksumType64Override -ne $null -and $checksumType64Override -ne '') { $checksumType64 = $checksumType64Override }

  $checksum32 = $checksum
  $checksumType32 = $checksumType
  $bitWidth = 32
  if (Get-ProcessorBits 64) { $bitWidth = 64 }

  Write-Debug "CPU is $bitWidth bit"

  $bitPackage = ''

  if ($url32bit -ne $url64bit -and $url64bit -ne $null -and $url64bit -ne '') { $bitPackage = '32 bit' }

  if ($bitWidth -eq 64 -and $url64bit -ne $null -and $url64bit -ne '') {
    Write-Debug "Setting url to '$url64bit' and bitPackage to $bitWidth"
    $bitPackage = '64 bit'
    $url = $url64bit
    if ($url32bit -ne $url64bit) {
      $checksum = $checksum64
      if ($checksumType64 -ne '') {
        $checksumType = $checksumType64
      }
    }
  }

  $forceX86 = $env:chocolateyForceX86
  if ($forceX86) {
    Write-Debug "User specified -x86 so forcing 32 bit"
    if ($url32bit -ne $url64bit) { $bitPackage = '32 bit' }
    $url = $url32bit
    $checksum = $checksum32
  }

  # If we're on 32 bit or attempting to force 32 bit and there is no
  # 32 bit url, we need to throw an error.
  if ($url -eq $null -or $url -eq '') {
    throw "This package does not support $bitWidth bit architecture."
  }

  if ($url.StartsWith('http:')) {
    $url = $url.Replace('http://', 'https://')
    Write-Warning "Fosshub supports SSL, switching to HTTPS for download."
  }

  $fileName = getFosshubFileName $url
  $fileDirectory = Get-PackageCacheLocation
  $fileFullPath = Join-Path $fileDirectory $fileName

  $needsDownload = $true
  $fiCached = New-Object System.IO.FileInfo($fileFullPath)
  if ($fiCached.Exists -and -not ($forceDownload)) {
    if ($checksum -ne $null -and $checksum -ne '') {
      try {
        Write-Host "File appears to be downloaded already. Verifying with package checksums to determine if it needs to be redownloaded."
        Get-ChecksumValid -file $fileFullPath -checkSum $checksum -checksumType $checksumType -ErrorAction "Stop"
        $needsDownload = $false
      } catch {
        Write-Debug "Existing file failed checksum. Will be redownloaded from url."
      }
    }
  }

  if ($needsDownload) {
    if (!($options["Headers"].ContainsKey('Referer'))) {
      $referer = getFosshubReferer $url
      $options["Headers"].Add('Referer', $referer)
    }
    $downloadUrl = get-UrlFromFosshub $url
    Get-WebFile -Url $downloadUrl -FileName $fileFullPath -Options $options
  }

  Start-Sleep 2

  $fi = New-Object System.IO.FileInfo($fileFullPath)
  if (!($fi.Exists)) { throw "Chocolatey expected a file to be downloaded to `'$fileFullPath`' but nothing exists at that location." }

  Get-VirusCheckValid -Location $url -File $fileFullPath

  if ($needsDownload -and ($checksum -ne $null -and $checksum -ne '')) {
    Write-Debug "Verifying package provided checksum fo '$checksum' for '$fileFullPath'."
    Get-ChecksumValid -File $fileFullPath -Checksum $checksum -ChecksumType $checksumType -OriginalUrl $url
  }

  return $fileFullPath
}


function getFosshubFileName() {
  param([string]$linkUrl)

  $linkUrl -match 'fosshub.com/(.*)/(.*)' | Out-Null
  if (!$Matches) {
    return''
  } else {
    return $Matches[2]
  }
}

function getFosshubReferer() {
  param([string]$linkUrl)

  $linkUrl -match 'fosshub.com/(.*)/' | Out-Null

  if (!$Matches) {
    return ''
  } else {
    "https://www.fosshub.com/$($Matches[1])"
  }
}

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
  $htmlPage = Get-WebContent -url $linkUrl -options $opts

  $dataLink = $htmlPage -match $regexPattern

  if (!$Matches) {
    return $linkUrl
  }

  return $Matches[1]
}
