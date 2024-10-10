﻿[CmdletBinding()]
param($IncludeStream, [switch]$Force)
Import-Module Chocolatey-AU

$releases = 'https://www.clipboardfusion.com/Download/'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*1\..+)\<.*\>"              = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
    }
  }
}

function global:au_GetLatest {
  $urls = @(
    "https://www.binaryfortress.com/Data/Download/?package=clipboardfusion&log=104&beta=0"
    "https://www.binaryfortress.com/Data/Download/?package=clipboardfusion&log=104&beta=1"
  )

  $streams = @{}
  $urls | ForEach-Object {
    try {
      $url = Get-RedirectedUrl $_ 3>$null
    }
    catch {
      return;
    }
    $verRe = '-|\.exe$'
    $version = $url -split "$verRe" | Select-Object -last 1 -skip 1
    if (!$version) { return }
    elseif ($version -match 'beta') { $version = ($url -split "$verRe" | Select-Object -last 1 -skip 2) + "-$version" }
    $version = Get-Version $version

    if (($_ -match 'beta=1') -and !$version.PreRelease) {
      $version += "-beta"
      $version.PreRelease = "beta"
    }

    if ($version.PreRelease) {
      $key = "unstable"
    }
    else {
      $key = "stable"
    }

    if (!($streams.ContainsKey($key))) {
      $streams.Add($key, @{
          Version = $version.ToString()
          URL32   = $url
        })
    }
  }

  return @{ Streams = $streams }
}

update -ChecksumFor none -IncludeStream $IncludeStream -Force:$Force
