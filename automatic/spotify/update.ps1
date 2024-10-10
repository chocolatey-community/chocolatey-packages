﻿Import-Module Chocolatey-AU
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"

$releases = 'https://www.spotify.com/en/download/windows/'
$padUnderVersion = '1.1.8'

function global:au_SearchReplace {
  return @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_AfterUpdate {
  "$($Latest.ETAG)|$($Latest.Version)" | Out-File "$PSScriptRoot\info" -Encoding utf8
}

function GetResultInformation([string]$url32) {
  $dest = "$env:TEMP\spotify.exe"
  Get-WebFile $url32 $dest | Out-Null
  $version = Get-Item $dest | ForEach-Object { $_.VersionInfo.ProductVersion -replace '^([\d]+(\.[\d]+){1,3}).*', '$1' }

  $result = @{
    URL32          = $url32
    Version        = Get-FixVersion -Version $version -OnlyFixBelowVersion $padUnderVersion
    Checksum32     = Get-FileHash $dest -Algorithm SHA512 | ForEach-Object Hash
    ChecksumType32 = 'sha512'
  }
  Remove-Item -Force $dest
  return $result
}

function GetETagIfChanged() {
  param([string]$uri)
  if (($global:au_Force -ne $true) -and (Test-Path $PSScriptRoot\info)) {
    $existingETag = $etag = Get-Content "$PSScriptRoot\info" -Encoding UTF8 | Select-Object -First 1 | ForEach-Object { $_ -split '\|' } | Select-Object -first 1
  }
  else { $existingETag = $null }

  $etag = Invoke-WebRequest -Method Head -Uri $uri -UseBasicParsing
  $etag = $etag | ForEach-Object { $_.Headers.ETag }
  if ($etag -eq $existingETag) { return $null }

  return $etag
}

function global:au_GetLatest {
  $downloadUrl = 'https://download.scdn.co/SpotifySetup.exe'
  $etag = GetETagIfChanged -uri $downloadUrl

  if ($etag) {
    $result = GetResultInformation $downloadUrl
    $result["ETAG"] = $etag
  }
  else {
    $result = @{
      URL32   = $downloadUrl
      Version = Get-Content "$PSScriptRoot\info" -Encoding UTF8 | Select-Object -First 1 | ForEach-Object { $_ -split '\|' } | Select-Object -Last 1
    }
  }

  return $result
}

update -ChecksumFor none
