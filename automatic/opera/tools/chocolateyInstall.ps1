$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/92.0.4561.21/win/Opera_92.0.4561.21_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/92.0.4561.21/win/Opera_92.0.4561.21_Setup_x64.exe'
  checksum       = '889268a414e11afd9511ef9625d4c020b3e8973e07082b3d4f757d5414771db8'
  checksum64     = '5c786c600ce5f032b346eb0ad041e61856b2fe3fda1d8e476c689d3e71e69b92'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '92.0.4561.21'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
