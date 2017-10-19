$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/48.0.2685.50/win/Opera_48.0.2685.50_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/48.0.2685.50/win/Opera_48.0.2685.50_Setup_x64.exe'
  checksum       = '186b93e96fc944c6b2a79acbb7eb75ce63e78677bdad7ddefa463b4b269f8f9c'
  checksum64     = 'fb721cbcc54ddb5b19ba84bbe52a841f560281a11331524972f483894e20fa51'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0'
  validExitCodes = @(0)
}

$version = '48.0.2685.50'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
