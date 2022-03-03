$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/84.0.4316.31/win/Opera_84.0.4316.31_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/84.0.4316.31/win/Opera_84.0.4316.31_Setup_x64.exe'
  checksum       = '70f0d2963445e2e66cb7caffee0eb3c05f0c30899583d524483c62421c5e66c1'
  checksum64     = 'a8b708cde27b3c0223cf6a809167a976ded7926be0b0e2ce2319dc7d27afb816'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '84.0.4316.31'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
