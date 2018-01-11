
function GetETagIfChanged() {
  param([string]$url)

  if (($global:au_Force -ne $true) -and (Test-Path $PSScriptRoot\info)) {
    $existingETag = Get-Content "$PSScriptRoot\info" -Encoding UTF8 | select -first 1 | % { $_ -split '\|' } | select -First 1
  }
  else {
    $existingETag = $null
  }

  $etag = Invoke-WebRequest -Method Head -Uri $url -UseBasicParsing
  $etag = $etag | % { $_.Headers.ETag }
  if ($etag -eq $existingETag) { return $null }

  return $etag
}

function GetResultInformation() {
  param([string]$url32)

  $dest = "$env:TEMP\w10mct.exe"
  Invoke-WebRequest -UseBasicParsing -Uri $url32 -OutFile $dest
  $version = Get-Item $dest | % { $_.VersionInfo.ProductVersion -replace '^(\d+(\.[\d]+){1,3}).*', '$1' }

  $result = @{
    URL32          = $url32
    Version        = $version
    Checksum32     = Get-FileHash $dest -Algorithm SHA512 | % Hash
    ChecksumType32 = 'sha512'
  }
  Remove-Item -Force $dest
  return $result
}