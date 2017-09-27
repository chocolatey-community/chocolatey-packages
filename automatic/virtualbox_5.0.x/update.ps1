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
  # Copy the original file from the virtualbox folder
  if (!(Test-Path "$PSScriptRoot\tools" -PathType Container)) { New-Item -ItemType Directory "$PSScriptRoot\tools" }
  Copy-Item "$PSScriptRoot\..\virtualbox\tools" "$PSScriptRoot" -Force -Recurse
  Move-Item "$PSScriptRoot\Readme.md" "$PSScriptRoot\Readme.md.backup" -Force
  Copy-Item "$PSScriptRoot\..\virtualbox\Readme.md" "$PSScriptRoot\Readme.md" -Force
  Move-Item "$PSScriptRoot\Readme.md.backup" "$PSScriptRoot\Readme.md" -Force
}

function global:au_GetLatest {
  $Latest = GetLatest $releases
  $Latest.PackageName = 'virtualbox'
  $Latest
}

update -ChecksumFor none
