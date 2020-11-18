$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/72.0.3815.371/win/Opera_72.0.3815.371_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/72.0.3815.371/win/Opera_72.0.3815.371_Setup_x64.exe'
  checksum       = '5495a5fd52d548e32dbf87613ce6e1dbd366aa3653f00c7a2f2bce15386fbd50'
  checksum64     = '7961cfb9921b39509ce28ae4faee5bfed23cfc969023fe0b7f47008c2c26c952'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '72.0.3815.371'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
