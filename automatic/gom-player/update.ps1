﻿Import-Module Chocolatey-AU

$releases     = 'https://www.gomlab.com/gomplayer-media-player/'
$versions     = 'https://www.gomlab.com/en/gomplayer-media-player/release-note'
$softwareName = 'GOM Player'

function global:au_BeforeUpdate {
  # We need this, otherwise the checksum won't get created
  # Since windows 8 or later is skipped.
  $Latest.ChecksumType32 = 'sha256'
  $Latest.Checksum32     = Get-RemoteChecksum $Latest.URL32
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
      "(?i)^(\s*url\s*=\s*)'.*'"          = "`${1}'$($Latest.URL32)'"
      "(?i)^(\s*checksum\s*=\s*)'.*'"     = "`${1}'$($Latest.Checksum32)'"
      "(?i)^(\s*checksumType\s*=\s*)'.*'" = "`${1}'$($Latest.ChecksumType32)'"
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '\.exe$'
  $url32 = $download_page.Links | Where-Object href -match $re | Select-Object -first 1 -expand href

  $verRe = '(V (?:\d+\.){2,3}\d+)'
  $version_page = Invoke-WebRequest -Uri $versions -UseBasicParsing
  if ($version_page.Content -match $verRe) {
    $version32 = $Matches[1].Trim('V ')
  }

  @{
    URL32   = $url32
    Version = Get-FixVersion $version32 -OnlyFixBelowVersion '2.3.34'
  }
}

# Fixes checksum by including global:au_BeforeUpdate
update -ChecksumFor none
