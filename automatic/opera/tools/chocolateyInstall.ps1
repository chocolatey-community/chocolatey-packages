$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/55.0.2994.61/win/Opera_55.0.2994.61_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/55.0.2994.61/win/Opera_55.0.2994.61_Setup_x64.exe'
  checksum       = '5ae1aefbd7e07ba5cf877dccdc9bb8a2333f1204ebb362cc70895a5ff746d515'
  checksum64     = '1dbe93f3b42b208c08fe2b26ea411bb1860dee07e8bc4d5ffe71772b0feb9f9b'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '55.0.2994.61'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
