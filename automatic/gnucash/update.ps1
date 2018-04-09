[CmdletBinding()]
param($IncludeStream, [switch]$Force)

import-module au
import-module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$domain = 'https://sourceforge.net'
$releases = "$domain/projects/gnucash/files/gnucash%20%28stable%29/"
$softwareName = 'GnuCash*'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix -FileNameSkip 1 }

function global:au_AfterUpdate {
  Update-ChangelogVersion -version $Latest.Version
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"        = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$($Latest.ReleasesUrl)>"
      "(?i)(\s*1\..+)\<.*\>"              = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1"   = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'"       = "`${1}'$softwareName'"
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  # We only grab the 5 latest updated folders, no need to take any more
  $releasesUrls = $download_page.Links | ? href -match "\/[\d\.]+\/$" | select -First 5 -expand href | % { $domain + $_ }

  $streams = @{}
  $releasesUrls | % {
    $download_page = Invoke-WebRequest -Uri $_ -UseBasicParsing
    $re = '\.exe\/download$'
    $url32 = $download_page.Links | ? href -match $re | select -expand href -First 1
    if (!$url32) { return }

    $verRe = 'h\-|(?:\-\d)?[\.\-]setup'
    $version = $url32 -split "$verRe" | select -last 1 -skip 1
    $version = Get-Version $version

    if (!($streams.ContainsKey($version.ToString(2)))) {
      $streams.Add($version.ToString(2), @{
          Version     = $version.ToString()
          URL32       = $url32
          ReleasesUrl = $_
          FileType    = 'exe'
        })
    }
  }

  return @{ Streams = $streams }
}

update -ChecksumFor none -IncludeStream $IncludeStream -Force:$Force
