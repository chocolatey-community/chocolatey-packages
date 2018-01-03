$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/50.0.2762.45/win/Opera_50.0.2762.45_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/50.0.2762.45/win/Opera_50.0.2762.45_Setup_x64.exe'
  checksum       = 'c67b3dc54c4e1ff367225a2cb1e903c7f9881aab93021624540760246e62233f'
  checksum64     = '997f2f3d603e5789e6bb78d9ce4ba718ecc9ece82d113c0145d97e9fcfc49222'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0'
  validExitCodes = @(0)
}

$version = '50.0.2762.45'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
