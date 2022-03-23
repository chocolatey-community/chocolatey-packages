$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/85.0.4341.18/win/Opera_85.0.4341.18_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/85.0.4341.18/win/Opera_85.0.4341.18_Setup_x64.exe'
  checksum       = '45cb7e3f0dcf1d91b3a6b0f9a0ee79d6d7e7cf171ec3ced6d63c2df294344ca4'
  checksum64     = '040e9a7fe6acc2c4118017c528fb4b8742dc2ae8cda2f28185e9b9e6bbe4184a'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '85.0.4341.18'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
