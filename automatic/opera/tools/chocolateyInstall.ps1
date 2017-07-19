$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

if (Is32BitInstalled) { $env:ChocolateyForceX86 = $true }

$version     = '46.0.2597.57'
$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/46.0.2597.57/win/Opera_46.0.2597.57_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/46.0.2597.57/win/Opera_46.0.2597.57_Setup_x64.exe'
  checksum       = 'a0b6c0e768b86b76817b38d22c42d943f43f73682e46a82062f41207d487ac63'
  checksum64     = '2e78427f49ff6f405fd849192a61c6726682c2e2504682852ad138b231adef87'
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
