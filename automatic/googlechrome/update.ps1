Import-Module Chocolatey-AU
import-module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = "https://versionhistory.googleapis.com/v1/chrome/platforms/win/channels/stable/versions"
$releasesBeta = "https://versionhistory.googleapis.com/v1/chrome/platforms/win/channels/beta/versions"
$paddedUnderVersion = '57.0.2988'

function global:au_BeforeUpdate {
  $Latest.Checksum32 = Get-RemoteChecksum $Latest.URL32
  $Latest.Checksum64 = Get-RemoteChecksum $Latest.URL64
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*url64bit\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
      "(?i)(^[$]version\s*=\s*)('.*')" = "`$1'$($Latest.RemoteVersion)'"
      "(?i)(^[$]softwareName\s*=\s*)('.*')" = "`$1'$($Latest.SoftwareName)'"
    }
  }
}

function global:au_AfterUpdate($Package) {
  Update-Metadata -data @{
    title      = $Latest.Title
  }
}

function global:au_GetLatest {
  $streams = [ordered]@{}

  $releasesData = Invoke-RestMethod -UseBasicParsing -Method Get -Uri $releases
  $version = ($releasesData.versions | Select-Object -First 1).version
  
  $streams["release"] = @{
    URL32 = 'https://dl.google.com/dl/chrome/install/googlechromestandaloneenterprise.msi'
    URL64 = 'https://dl.google.com/dl/chrome/install/googlechromestandaloneenterprise64.msi'
    Version = Get-FixVersion $version -OnlyFixBelowVersion $paddedUnderVersion
    RemoteVersion = $version
    PackageName = 'GoogleChrome'
    Title = "Google Chrome"
    SoftwareName = "Google Chrome"
  }
  
  $releasesDataBeta = Invoke-RestMethod -UseBasicParsing -Method Get -Uri $releasesBeta
  $versionBeta = ($releasesDataBeta.versions | Select-Object -First 1).version + "-beta"
  
  $streams["beta"] = @{
    URL32 = 'https://dl.google.com/tag/s/dl/chrome/install/beta/googlechromebetastandaloneenterprise.msi'
    URL64 = 'https://dl.google.com/tag/s/dl/chrome/install/beta/googlechromebetastandaloneenterprise64.msi'
    Version = $versionBeta
    RemoteVersion = $versionBeta
    PackageName = 'GoogleChrome'
    Title = "Google Chrome Beta"
    SoftwareName = "Google Chrome Beta"
  }

  return @{ Streams = $streams }
}

update -ChecksumFor none
