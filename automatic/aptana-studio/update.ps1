﻿Import-Module Chocolatey-AU

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_AfterUpdate {
  @{
    Version = $Latest.RemoteVersion
    URL32 = $Latest.URL32
  } | ConvertTo-Json | Out-File "$PSScriptRoot\url.json" -Encoding utf8
  $global:au_Force = $false
}

function HasUrlChanged([string]$version, [string]$url)
{
  if (Test-Path "$PSScriptRoot\url.json") {
    $info = Get-Content "$PSScriptRoot\url.json" -Encoding UTF8 | ConvertFrom-Json
    if (!$info.URL32) { return $false } # We don't want the update to be forced if no previous url is set
    if ($info.Version -eq $version -and $info.URL32 -ne $url) {
      # Let us test if the older url actually still works, if not we'll return true
      try {
        Invoke-WebRequest -UseBasicParsing -Uri $info.URL32 -Method Head | Out-Null
        return $false
      }
      catch {
        return $true
      }
    }
  }
}

function global:au_GetLatest {
  $LatestRelease = Get-GitHubRelease aptana studio3
  $url = $LatestRelease.assets | Where-Object {$_.name.EndsWith("Setup.exe")} | Select-Object -ExpandProperty browser_download_url
  $version = $LatestRelease.tag_name.TrimStart('v') -replace "^([\d]+\.[\d+]\.[\d]+)\..*$",'$1'

  if (HasUrlChanged -version $version -url $url) {
    $global:au_Force = $true
  }

  @{
    URL32 = $url
    Version = $version
    RemoteVersion = $version
  }
}

update -ChecksumFor 32
