. "$PSScriptRoot\..\virtualbox\update.ps1"
import-module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"

$releases = 'https://www.virtualbox.org/wiki/Download_Old_Builds_5_0'

function global:au_BeforeUpdate {
  $Latest.ChecksumType32 = 'sha256'
  $Latest.Checksum32 = Get-RemoteChecksum -Algorithm $Latest.ChecksumType32 -Url $Latest.URL32
}

function global:au_GetLatest {
  $Latest = GetLatest $releases
  $Latest.PackageName = 'virtualbox'
  $Latest
}

update -ChecksumFor none
