$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/60.0.3255.56/win/Opera_60.0.3255.56_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/60.0.3255.56/win/Opera_60.0.3255.56_Setup_x64.exe'
  checksum       = '3200982ac23fe9e6af42ca9dce239bb90ab855e01302ac99d1dcd39c8228d1ca'
  checksum64     = 'be72dda477454f782cf613e713034ee26961b72a5bcf2f872b584b3b2531f112'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '60.0.3255.56'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
