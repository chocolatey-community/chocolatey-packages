$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/52.0.2871.40/win/Opera_52.0.2871.40_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/52.0.2871.40/win/Opera_52.0.2871.40_Setup_x64.exe'
  checksum       = '01528c96980675e3aee9deaf4b0dabd86b20e1d809e280f6909434e34ce9d99b'
  checksum64     = 'c60a7674c5528dbd9ec1b4a2cbcdaccfd9aa8fb400e9afe74d1d104f0d07f5a3'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0'
  validExitCodes = @(0)
}

$version = '52.0.2871.40'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
