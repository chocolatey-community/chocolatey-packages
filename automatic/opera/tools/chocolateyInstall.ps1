$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/101.0.4843.25/win/Opera_101.0.4843.25_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/101.0.4843.25/win/Opera_101.0.4843.25_Setup_x64.exe'
  checksum       = '6dbe664cea90d874ff1870cacadaa5482bfd64f0a4a86c46e70c2bc144b0e5e3'
  checksum64     = 'e09f0663827126ae88e211f322aa0075fda3ebdcd4eaf81330a06365d70a133c'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '101.0.4843.25'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
