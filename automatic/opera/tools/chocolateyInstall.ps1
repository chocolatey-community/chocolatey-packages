$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/81.0.4196.54/win/Opera_81.0.4196.54_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/81.0.4196.54/win/Opera_81.0.4196.54_Setup_x64.exe'
  checksum       = 'd742e76ef8bc6c4b0be102d9f4391961aaf203db966902c14d26eb4effbf92f0'
  checksum64     = 'b9bc40b5c611d9f6ddde489154d87a2c8b4ad89ae02c6c278bbe7a8a94a73796'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '81.0.4196.54'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
