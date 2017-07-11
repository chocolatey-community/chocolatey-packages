$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

if (Is32BitInstalled) { $env:ChocolateyForceX86 = $true }

$version     = '46.0.2597.46'
$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/46.0.2597.46/win/Opera_46.0.2597.46_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/46.0.2597.46/win/Opera_46.0.2597.46_Setup_x64.exe'
  checksum       = 'f09e5e0b633b3c3b1f697c06d434b6a6a27bf30cd81e98b8ddc26980232d2e7b'
  checksum64     = '8cecdb650d208896078bbfe5776f2289535291822f1bc02031d2ae2ed352ef91'
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
