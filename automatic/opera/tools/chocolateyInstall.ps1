$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/95.0.4635.46/win/Opera_95.0.4635.46_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/95.0.4635.46/win/Opera_95.0.4635.46_Setup_x64.exe'
  checksum       = '02b921a0b04d4302709d2e74b581c5cd7c8e7fee39bc4f224eab8758d102a9c4'
  checksum64     = '7edaac368b017631b830790d535a428a6e90c0699e47b74d7b9ccbcd9d180ed7'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '95.0.4635.46'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
