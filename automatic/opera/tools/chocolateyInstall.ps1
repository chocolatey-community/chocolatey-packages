$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/48.0.2685.52/win/Opera_48.0.2685.52_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/48.0.2685.52/win/Opera_48.0.2685.52_Setup_x64.exe'
  checksum       = '6c7fea56a89aa75dba8508ccc4bdde74cadee89db04a6044abe8bca47b9d9891'
  checksum64     = '3f50eb0979c8e124f3eeb002feafb252bf9345fc37f25be5ae489cc1b49a65f9'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0'
  validExitCodes = @(0)
}

$version = '48.0.2685.52'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
