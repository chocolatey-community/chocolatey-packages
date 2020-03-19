$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/67.0.3575.97/win/Opera_67.0.3575.97_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/67.0.3575.97/win/Opera_67.0.3575.97_Setup_x64.exe'
  checksum       = '9b4afc64e6cab8ba16a7144d8eaf518125e586f0b0af605ec3ae5ec6e9344dd9'
  checksum64     = 'e361b00bc5ae4f5ff875530a009f0f705a68b6effeef444c283e86ffd504453b'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '67.0.3575.97'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
