$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/72.0.3815.211/win/Opera_72.0.3815.211_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/72.0.3815.211/win/Opera_72.0.3815.211_Setup_x64.exe'
  checksum       = '3cab4a52917b7e8e45db3a3eeb535a780091e108312264ca9e4bc69d40e7d0e4'
  checksum64     = '49015bd30bc6942f4952fca2383fe3394dfb4fe14ca3ce9ee83b1bd29b1d59ff'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '72.0.3815.211'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
