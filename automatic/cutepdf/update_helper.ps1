
function GetETagIfChanged() {
  param([string]$url)

  if (!(Test-Path $PSScriptRoot\info)) {
  New-Item $PSScriptRoot\info -ItemType file
  }

  if (($global:au_Force -ne $true) -and (Test-Path $PSScriptRoot\info)) {
    $existingETag = Get-Content "$PSScriptRoot\info" -Encoding "UTF8" | Select -First 1 | Foreach { $_ -split '\|' } | Select -First 1
  }
  else {
    $existingETag = $null
  }

  $etag = Invoke-WebRequest -Method Head -Uri $url -UseBasicParsing
  # $etag = $etag | Foreach { $_.Headers.ETag }
  $etag = $etag | Foreach { $_.Headers["Content-Length"] }
  if ($etag -eq $existingETag) { return $null }

  return $etag
}

function GetResultInformation() {
  param([string]$url32,[string]$file)

  $dest = "$env:TEMP\$file"
  Invoke-WebRequest -UseBasicParsing -Uri $url32 -OutFile $dest
  $version = Get-Item $dest | Foreach { $_.VersionInfo.FileVersion -replace '^(\d+(\.[\d]+){1,3}).*', '$1' }
  $version = Get-FixVersion -Version $version -OnlyFixBelowVersion "4.0.1"

  $result = @{
    URL32          = $url32
    Version        = $version
    Checksum32     = Get-FileHash $dest -Algorithm "SHA512" | Foreach Hash
    ChecksumType32 = 'sha512'
  }
  Remove-Item -Force $dest
  return $result
}
