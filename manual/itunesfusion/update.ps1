Import-Module AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

function global:au_GetLatest {
  $downloadEndPointUrl = 'https://www.binaryfortress.com/Data/Download/?package=retired_itunesfusion_retired&log=100'
  $versionRegEx = 'iTunesFusionSetup-([0-9\.\-]+)\.exe'

  $downloadUrl = Get-RedirectedUrl $downloadEndPointUrl
  $versionInfo = $downloadUrl -match $versionRegEx

  if ($matches) {
    $version = $matches[1]
  }

  return @{ Url32 = $downloadUrl; Version = $version }
}

function global:au_AfterUpdate {
  Update-ChangelogVersion -version $Latest.Version
}

function global:au_SearchReplace {
  return @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.Url32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

$global:au_Force = $true # Just to allow forced updates
Update -ChecksumFor 32
