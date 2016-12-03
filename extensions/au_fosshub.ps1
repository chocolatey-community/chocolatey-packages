function Get-FosshubChecksum() {
<#
.SYNOPSIS
Helper function for aquiring the checksum of the file hosted on fosshub

.NOTES
This function downloads the file as a temporary stream, without saving it to the disk

This function don't do any error checking

.EXAMPLE
Get-FosshubChecksum -url 'https://www.fosshub.com/qBittorrent.html/qbittorrent_3.3.7_setup.exe' -Algorithm 'sha256'

.OUTPUTS
The hash as outputted from the Get-FileHash
#>
  param(
    [string]$url,
    [ValidateSet('md5','sha1','sha256','sha512')]
    [string]$algorithm
  )

  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $url

  $url -match '^https:\/\/(?:www\.)fosshub\.com(.+)$' | Out-Null
  $urlPart = $Matches[1]

  $urlElement = $download_page.links | ? href -match "^$urlPart$" | select -first 1

  $downloadUrl = $urlElement.PSObject.Properties | ? {
    $_.Value -match "^https:\/\/download\.fosshub\.com"
  } | select -first 1 -expand Value

  $stream = Invoke-WebRequest -UseBasicParsing -Uri $downloadUrl -Headers @{ 'Referer' = $url } | select -expand RawContentStream

  $res = Get-FileHash -Algorithm $algorithm -InputStream $stream | % Hash
  $stream.Dispose()
  $res
}
