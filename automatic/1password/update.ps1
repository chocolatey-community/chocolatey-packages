[CmdletBinding()]
param($IncludeStream, [switch] $Force)

Import-Module AU

$releases = 'https://1password.com/downloads/'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*url\s*=\s*)'.*'" = "`${1}'$($Latest.URL32)'"
      "(?i)^(\s*checksum\s*=\s*)'.*'" = "`${1}'$($Latest.Checksum32)'"
      "(?i)^(\s*checksumType\s*=\s*)'.*'" = "`${1}'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_AfterUpdate {
  . "$PSScriptRoot/update_helper.ps1"
  if ($Latest.PackageName -eq '1password4') {
    removeDependencies ".\*.nuspec"
  } else {
    addDependency ".\*.nuspec" 'dotnet4.6.1' '4.6.01055.20170308'
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $streams = @{}
  $res = @('OPW4';'format=zip$')
  $res | % {
    $re = $_
    $url32 = $download_page.Links | ? href -match $re | select -First 1 -expand href
    $url32 = Get-RedirectedUrl $url32

    $verRe = '[-]|\.exe$'
    $version = $url32 -split $verRe | select -last 1 -skip 1
    $version = Get-Version $version
    $major = $version.ToString(1)
    $kind = if ($major -eq 4) { 'legacy' } else { 'latest' }

    if (!($streams.ContainsKey($kind))) {
      $streams.Add($kind, @{
        URL32 = $url32
        Version = $version.ToString()
        PackageName = if ($kind -eq 'legacy') { '1password4' } else { '1password' }
      })
    }
  }

  return @{ Streams = $streams }
}

update -ChecksumFor 32 -IncludeStream $IncludeStream -Force:$Force
