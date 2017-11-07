$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/49.0.2725.34/win/Opera_49.0.2725.34_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/49.0.2725.34/win/Opera_49.0.2725.34_Setup_x64.exe'
  checksum       = 'f34905173f5849e2c9aa16683b796028ee7cc8c6c7245cb0f1911b66f1bbe1df'
  checksum64     = 'b8c949fcad47bed35935e4c8c8ceeeba01b12e966f7ce07ca9ebc2e696da7be2'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0'
  validExitCodes = @(0)
}

$version = '49.0.2725.34'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
