﻿import-module au

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1"           = @{
      "(?i)(^\s*url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
      "(?i)([$]softwareVersion\s*=\s*)'.*'"   = "`${1}'$($Latest.Version)'"
    }
    "legal\VERIFICATION.txt"  = @{
      "(?i)(x86:).*"          = "`${1} $($Latest.URL32)"
      "(?i)(x86_64:).*"       = "`${1} $($Latest.URL64)"
      "(?i)(checksum32:).*"   = "`${1} $($Latest.Checksum32)"
      "(?i)(checksum64:).*"   = "`${1} $($Latest.Checksum64)"
    }
    "brave.nuspec"                     = @{
      "(\<title\>).*(\<\/title\>)"     = "`${1}$($Latest.Title)`$2"
      "(\<iconUrl\>).*(\<\/iconUrl\>)" = "`${1}$($Latest.IconUrl)`$2"
    }
  }
}

function global:au_BeforeUpdate {
  $Latest.Checksum32 = Get-RemoteChecksum $Latest.URL32
  $Latest.Checksum64 = Get-RemoteChecksum $Latest.URL64
  $stream_readme = if ($Latest.Title -like '*Beta*') { 'README-beta.md' } else { 'README-release.md' }
  cp $stream_readme $PSScriptRoot\README.md -Force
  Get-RemoteFiles -Purge -NoSuffix
  # CRUFT - The above function does not provide for ignoring one file so we need to delete the 32bit version.
  $toolsPath = Resolve-Path tools
  rm -Force "$toolsPath\BraveBrowserStandaloneSilent*Setup32.exe"

}

function Get-Stream {
  param(
      [string]$ReleaseUrl,
      [string]$Title,
      [string]$DownloadUrl32,
      [string]$DownloadUrl64,
      [string]$VersionFormat,
      [string]$IconUrl
  )

  $releaseInformation = Invoke-RestMethod -Uri $ReleaseUrl
  $versionNumber = $releaseInformation

  @{
    Title     = $Title
    Version   = $VersionFormat -f $versionNumber
    URL32     = $DownloadUrl32 -f $versionNumber
    URL64     = $DownloadUrl64 -f $versionNumber
    IconUrl   = $IconUrl
  }
}

function global:au_GetLatest {
  $availableStreams = [ordered] @{
    stable = @{
      Title           = 'Brave Browser'
      ReleaseUrl      = 'https://brave-browser-downloads.s3.brave.com/latest/release.version'
      DownloadUrl32   = 'https://github.com/brave/brave-browser/releases/download/v{0}/BraveBrowserStandaloneSilentSetup32.exe'
      DownloadUrl64   = 'https://github.com/brave/brave-browser/releases/download/v{0}/BraveBrowserStandaloneSilentSetup.exe'
      VersionFormat   = '{0}'
      IconUrl         = 'https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-coreteampackages@a23ca306537e2537a574ddc55e9c28dc1151ab30/icons/brave.svg'
    }
    beta = @{
      Title           = 'Brave Browser (Beta)'
      ReleaseUrl      = 'https://brave-browser-downloads.s3.brave.com/latest/beta.version'
      DownloadUrl32   = 'https://github.com/brave/brave-browser/releases/download/v{0}/BraveBrowserStandaloneSilentBetaSetup32.exe'
      DownloadUrl64   = 'https://github.com/brave/brave-browser/releases/download/v{0}/BraveBrowserStandaloneSilentBetaSetup.exe'
      VersionFormat   = '{0}-beta'
      IconUrl         = 'https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-coreteampackages@a23ca306537e2537a574ddc55e9c28dc1151ab30/icons/brave-beta.svg'
    }
  }

  $streams = [ordered] @{}
  $errors = [ordered] @{}

  ForEach ($stream in $availableStreams.GetEnumerator()) {
      Try {
          $streamData = $stream.Value
          $streams[$stream.Name] = Get-Stream @streamData
      }
      Catch {
          $streams[$stream.Name] = 'ignore'
          $errors[$stream.Name] = $_
      }
  }

  if ($errors.Count) {
      Write-Error $errors
  }

  return @{ Streams = $streams }
}

update -ChecksumFor none