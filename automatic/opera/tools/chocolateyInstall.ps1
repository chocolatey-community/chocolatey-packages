$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/52.0.2871.37/win/Opera_52.0.2871.37_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/52.0.2871.37/win/Opera_52.0.2871.37_Setup_x64.exe'
  checksum       = '07d2c4d005626d2632250a939af412ef6ef69f508fecd92ecd5a7475fac0b915'
  checksum64     = '404d016d6fade9ddbfa24d3d96401456ef7980d57eb9cfcc5b6e9037879b2a74'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0'
  validExitCodes = @(0)
}

$version = '52.0.2871.37'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
