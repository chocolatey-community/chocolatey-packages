$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/54.0.2952.60/win/Opera_54.0.2952.60_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/54.0.2952.60/win/Opera_54.0.2952.60_Setup_x64.exe'
  checksum       = 'd842b044e66f7f6bafc55b88275ac867dc6d77aa999e01f780bfc37688bd0031'
  checksum64     = '0e8457330d070d4180ec1a458c1c57577db517c683a4aa80ab840769feb0d030'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '54.0.2952.60'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
