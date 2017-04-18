. "$PSScriptRoot\..\virtualbox\update.ps1"
import-module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"

# this update file and package exists only to provide bug fixes for
# the officially supported 5.0.x versions of virtualbox
# it is meant to submit these bug fix packages to the original
# virtualbox package.

$releases = 'https://www.virtualbox.org/wiki/Download_Old_Builds_5_0'

function global:au_BeforeUpdate {
  $Latest.ChecksumType32 = 'sha256'
  $Latest.Checksum32 = Get-RemoteChecksum -Algorithm $Latest.ChecksumType32 -Url $Latest.URL32
}

function global:au_AfterUpdate {
  pushd "$PSScriptRoot\..\virtualbox"
  Set-DescriptionFromReadme -SkipFirst 2
  popd
}

function global:au_GetLatest {
  $Latest = GetLatest $releases
  $Latest.PackageName = 'virtualbox'
  $Latest
}

update -ChecksumFor none
