$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/62.0.3331.66/win/Opera_62.0.3331.66_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/62.0.3331.66/win/Opera_62.0.3331.66_Setup_x64.exe'
  checksum       = '44d05e83705b4dd4f6c9fb40380963e4e8e71ca0966d085409bc994e83e8b68c'
  checksum64     = 'ae4e6b6af92277176f47800c4951dfcf32f0f3ac7c11a245498552311dffd95d'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '62.0.3331.66'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
