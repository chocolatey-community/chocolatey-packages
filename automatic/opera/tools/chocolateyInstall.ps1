$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/50.0.2762.58/win/Opera_50.0.2762.58_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/50.0.2762.58/win/Opera_50.0.2762.58_Setup_x64.exe'
  checksum       = '18c30c5e645471a0b423008cac640e9616d01d54f00eadccb2f1e2d19e45bcb1'
  checksum64     = '3b60ab504d49997400674269c4f8641c81907d61e8a29403205a34ab819703e4'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0'
  validExitCodes = @(0)
}

$version = '50.0.2762.58'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
