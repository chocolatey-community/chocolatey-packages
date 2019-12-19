$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/65.0.3467.78/win/Opera_65.0.3467.78_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/65.0.3467.78/win/Opera_65.0.3467.78_Setup_x64.exe'
  checksum       = '252733d6e322d832d1c90e7e0d64c0ec5d08fb09eb5f722cc5a2a9030e4f648f'
  checksum64     = 'faf3e4019989c32cf999f62b41775f3f8b5cfa1e101156516da8119c7f030a1a'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '65.0.3467.78'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
