$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/70.0.3728.119/win/Opera_70.0.3728.119_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/70.0.3728.119/win/Opera_70.0.3728.119_Setup_x64.exe'
  checksum       = '95eec66520687c8012403b5b42712501a92eb049219c45b3b9c7360f7a1bde1b'
  checksum64     = '9f45ead835cf8ae25eb3a61b98390cad3222e7c3aaf30e3aff4bd6307319c5cb'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '70.0.3728.119'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
