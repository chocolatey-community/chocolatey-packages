﻿Import-Module Chocolatey-AU

$releases = 'https://get.geo.opera.com/pub/opera/desktop/'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
      "(^\s*url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
      "(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
      "(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
      "(^[$]version\s*=\s*)('.*')"    = "`$1'$($Latest.Version)'"
    }
    ".\opera.nuspec"                 = @{
      "(?i)(^\s*\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
    }
  }
}

function global:au_BeforeUpdate {
  $Latest.Checksum32 = Get-RemoteChecksum $Latest.URL32
  $Latest.Checksum64 = Get-RemoteChecksum $Latest.URL64
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $versionSort   = { [version]$_.href.TrimEnd('/') }
  $download_page = $download_page.links | Where-Object href -match '^[\d]+[\d\.]+\/$' | Sort-Object $versionSort -Descending | ForEach-Object {
    [version] $version = $_.href -replace '/', ''
    $url               = "https://get.geo.opera.com/pub/opera/desktop/$version/win/"
    try {
      $result = Invoke-WebRequest -Uri $url -UseBasicParsing
      return $result
    }
    catch { }
  } | Select-Object -First 1

  $url32 = $download_page.Links | Where-Object href -NotMatch 'x64' | Where-Object href -Match 'Setup\.exe$' | Select-Object -First 1 -expand href | ForEach-Object { $url + $_ }
  $url64 = $download_page.Links | Where-Object href -Match "(x64.*Setup|Setup_x64)\.exe$" | Select-Object -First 1 -expand href | ForEach-Object { $url + $_ }

  if (!$url32 -or !$url64) {
    throw "32bit or 64bit url was not found, investigate or ignore."
  }
  return @{
    URL32        = $url32
    URL64        = $url64
    Version      = $version
    PackageName  = 'Opera'
    ReleaseNotes = "https://blogs.opera.com/desktop/changelog-for-$($version.Major)/#b$($version.Build).$($version.Revision)"
  }
}

update -ChecksumFor none
