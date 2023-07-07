$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/100.0.4815.47/win/Opera_100.0.4815.47_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/100.0.4815.47/win/Opera_100.0.4815.47_Setup_x64.exe'
  checksum       = '99a04e7ec8e7d1dcfc260f9e21c4060cbf206bbb8d313e7b088fe8cf63fa88ca'
  checksum64     = '4170130a37c0a950d9987ead89ad6f3711e47730297f8670391a82ad7d0fc1bd'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '100.0.4815.47'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
