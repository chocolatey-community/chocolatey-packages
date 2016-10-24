
function GetPackageCacheLocation () {
  $chocoTemp      = $env:TEMP
  $packageName    = $env:chocolateyPackageName
  $packageVersion = $env:chocolateyPackageVersion

  $packageTemp = Join-Path $chocoTemp $packageName
  if ($packageVersion) {
    $packageTemp = Join-Path $packageTemp $packageVersion
  }

  $packageTemp
}

function GetTempFileName () {
  $tempDir = GetPackageCacheLocation
  $fileName = [System.IO.Path]::GetRandomFileName()

  $tempFile = Join-Path $tempDir $fileName

  $tempFile
}

<#
.SYNOPSIS
  Download file with choco internals.
.DESCRIPTION
  This function will download a file from specified url and return it as a string.
  This command should be a replacement for ubiquitous WebClient in install scripts.
.PARAMETER url
  Url to download.
.PARAMETER options
  Additional options for http request.
  For know only Headers property supported.
.EXAMPLE
  PS C:\> $s = Get-WebContent "http://example.com"
  PS C:\> $s -match 'Example Domain'
  True

  First command downloads html content from http://example.com and stores it in $s.
  Now you can parse and match it as a string.
.EXAMPLE
  PS C:\> $opts = @{ Headers = @{ Referer = 'http://google.com' } }
  PS C:\> $s = Get-WebContent -url "http://example.com" -options $opts

  You can set headers for http request this way.
.INPUTS
  None
.OUTPUTS
  System.String
.NOTES
  This function can only return string content.
  If you want to download a binary content, please use Get-WebFile.
.LINK
  Get-WebFile
#>
function Get-WebContent ([string]$url, [hashtable]$options) {
  $filePath = GetTempFileName
  Get-WebFile -url $url -fileName $filePath -options $options

  $fileContent = Get-Content $filePath -ReadCount 0 | Out-String
  Remove-Item $filePath

  $fileContent
}

Export-ModuleMember -Function Get-WebContent
