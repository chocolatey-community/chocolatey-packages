$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/92.0.4561.30/win/Opera_92.0.4561.30_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/92.0.4561.30/win/Opera_92.0.4561.30_Setup_x64.exe'
  checksum       = '89db5d8affe9e08cfb09673c81cd9ba6b09e6bccab71a0e42126179b2888ce7a'
  checksum64     = '2b8c99dad3d573bfd37f2d545f62c2e7221ed59b729d3146b9da6d07f2382c10'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '92.0.4561.30'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
