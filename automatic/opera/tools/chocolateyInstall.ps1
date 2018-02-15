$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/51.0.2830.34/win/Opera_51.0.2830.34_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/51.0.2830.34/win/Opera_51.0.2830.34_Setup_x64.exe'
  checksum       = 'f6e9f1c3ba37b25476f6bd0da8e13a14ab175f021d48914546d4ce830f27e86a'
  checksum64     = '74bcfc1ab8c8adbe105e4e0200f0ff36147e4dacb51d6f8fbb7fe894bf3751eb'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0'
  validExitCodes = @(0)
}

$version = '51.0.2830.34'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
