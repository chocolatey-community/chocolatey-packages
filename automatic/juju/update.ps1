[CmdletBinding()]
param($IncludeStream, [switch] $Force)

import-module au

$releases = 'https://launchpad.net/juju/+download'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(`"[$]toolsDir\\).*`"" = "`${1}$($Latest.FileName32)`""
    }
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(1\..+)\<.*\>"      = "`${1}<$($Latest.URL32)>"
      "(?i)(checksum type:).*" = "`${1} $($Latest.ChecksumType32)"
      "(?i)(checksum:).*"      = "`${1} $($Latest.Checksum32)"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

  $re    = '\.exe$'
  $urls   = $download_page.links | ? href -match $re | select -expand href

  $streams = @{}

  $urls | % {
    $versionArr = $_ -split 'setup[-]|[-]signed|.exe'
    if ($versionArr[1]) {
      $version = Get-Version $versionArr[1]
    } else {
      $version = Get-Version $versionArr[0]
    }

    if (!$streams.ContainsKey($version.ToString(2))) {
      $streams.Add($version.ToString(2), @{ URL32 = $_ ; Version = $version.ToString() })
    }
  }

  return @{ Streams = $streams }
}

update -ChecksumFor none -IncludeStream $IncludeStream -Force:$Force
