[CmdletBinding()]
param($IncludeStream, [switch]$Force)
Import-Module AU

$releases = 'https://owncloud.org/download/#install-clients'
$softwareName = 'ownCloud'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"        = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
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

function global:au_AfterUpdate {
  Update-Metadata -key "title" -value $Latest.Title
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = 'ownCloud\-.*\.exe$'
  $urls32 = $download_page.Links | ? href -match $re | select -expand href

  $streams = @{}
  $urls32 | % {
    $verRe = '[-]|\.exe$'
    $version = $_ -split "$verRe" | select -last 1 -skip 2
    $version = Get-Version $version
    $kind = $_ -split '\/' | select -last 1 -skip 1

    if (!($streams.ContainsKey($kind))) {
      $streams.Add($kind, @{
          Version = $version.ToString()
          URL32   = $_
          Title   = if ($_ -match 'testing') { "ownCloud Windows Client (Technical Preview)" } else { "ownCloud Windows Client" }
        })
    }
  }

  return @{ Streams = $streams }
}

update -ChecksumFor none -IncludeStream $IncludeStream -Force:$Force
