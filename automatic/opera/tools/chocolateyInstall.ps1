$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/75.0.3969.218/win/Opera_75.0.3969.218_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/75.0.3969.218/win/Opera_75.0.3969.218_Setup_x64.exe'
  checksum       = 'bd348a261ff0a34fb41fece9a53c90a5ac5046bbd5df8d872d86d2efc73694a8'
  checksum64     = '5c329db88657108ec7e580eca3e562d2b10a127ae6348fb235a8a2313f64d7d1'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '75.0.3969.218'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
