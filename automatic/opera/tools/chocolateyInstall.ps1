$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/65.0.3467.69/win/Opera_65.0.3467.69_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/65.0.3467.69/win/Opera_65.0.3467.69_Setup_x64.exe'
  checksum       = '3ff7952f3ec3e13fa229c160b7a5993ef813ef3ad96b02054fdc8993620e3b31'
  checksum64     = '4713599700f92033ba3ac12ecca47fba7f786076e4df25fcca8ad3a3b18f09d3'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '65.0.3467.69'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
