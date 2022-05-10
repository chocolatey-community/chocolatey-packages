$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/86.0.4363.59/win/Opera_86.0.4363.59_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/86.0.4363.59/win/Opera_86.0.4363.59_Setup_x64.exe'
  checksum       = '48f79dc2a50adfcdb55945b91ff2fc151f8b70e7b7c1f6b2a393e2c11e694c6f'
  checksum64     = '66beed125e2178b92dfdbe9124b92f95a69ca8d28931e632c3c181604b7e1fa3'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '86.0.4363.59'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
