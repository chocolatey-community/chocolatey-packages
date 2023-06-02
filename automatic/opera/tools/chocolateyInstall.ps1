$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/99.0.4788.47/win/Opera_99.0.4788.47_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/99.0.4788.47/win/Opera_99.0.4788.47_Setup_x64.exe'
  checksum       = '750817536be0668af6d5ae2651b530ff64e447a8bfc1448cba9df744ff717159'
  checksum64     = 'bc080ca743b2aa452073cfcdfdd9fdcead78d20a35a26b9d27c7376c9d105ab4'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '99.0.4788.47'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
