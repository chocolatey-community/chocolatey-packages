$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/64.0.3417.61/win/Opera_64.0.3417.61_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/64.0.3417.61/win/Opera_64.0.3417.61_Setup_x64.exe'
  checksum       = '926a7f39719e8a8826bc4afb388fc6e0430abd55322b755696045441a5ce4396'
  checksum64     = '1ba15230f2ca8753c1607a848c9d1ba58fe36a6a5c629b2a995d25b26c8c01ae'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '64.0.3417.61'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
