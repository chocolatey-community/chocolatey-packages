$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/60.0.3255.84/win/Opera_60.0.3255.84_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/60.0.3255.84/win/Opera_60.0.3255.84_Setup_x64.exe'
  checksum       = '88723124d7e3fe93b80f12cf0d613a762806aea75c280f27ad610ff499cf98b2'
  checksum64     = '1be2928f34ccb591d7b284bf9befe4bc9175d9b71fd93599b86a240344c7b829'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '60.0.3255.84'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
