$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/49.0.2725.47/win/Opera_49.0.2725.47_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/49.0.2725.47/win/Opera_49.0.2725.47_Setup_x64.exe'
  checksum       = '89948d0ef5a4da14b74a5b168076fcb10be61fcb68afc7a3189b3794e1fb90c5'
  checksum64     = '2094fcdb1a9c3e47dc497e0b0fa8f8c706154ea3282f497711f4794769080df2'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0'
  validExitCodes = @(0)
}

$version = '49.0.2725.47'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
