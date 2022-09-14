$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/91.0.4516.16/win/Opera_91.0.4516.16_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/91.0.4516.16/win/Opera_91.0.4516.16_Setup_x64.exe'
  checksum       = '22fc6dff9a5d5a1deb5c78a5552c752b30027db9e891e45f76732765e5951305'
  checksum64     = '6b1f596c6660c4404c386a6bc3387c5df2429df7871e7987bbe4df5862231de1'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '91.0.4516.16'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
