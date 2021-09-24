$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/79.0.4143.66/win/Opera_79.0.4143.66_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/79.0.4143.66/win/Opera_79.0.4143.66_Setup_x64.exe'
  checksum       = 'c795ffdf7593e63ea6b46cca27d5e7494ff83743932068afeb88f09ed950349f'
  checksum64     = '7031c8d8795abe95488a90b9ac90aa0928e2d89d5543d94bf876528c71585b48'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '79.0.4143.66'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
