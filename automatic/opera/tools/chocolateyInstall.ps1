$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

if (Is32BitInstalled) { $env:ChocolateyForceX86 = $true }

$version     = '47.0.2631.48'
$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/47.0.2631.48/win/Opera_47.0.2631.48_i386_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/47.0.2631.48/win/Opera_47.0.2631.48_x64_Setup.exe'
  checksum       = 'ac978fe32372106ac07ab73aa8278144a06a0b86c871114010a0c8b14720ccd0'
  checksum64     = '953c40fec6263b2aaa5d34093abf0ce8b93b59503493772b3a9debaab910f158'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0'
  validExitCodes = @(0)
}

if (IsVersionAlreadyInstalled $version) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
