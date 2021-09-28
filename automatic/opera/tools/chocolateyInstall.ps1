$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/79.0.4143.72/win/Opera_79.0.4143.72_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/79.0.4143.72/win/Opera_79.0.4143.72_Setup_x64.exe'
  checksum       = 'e7f0940cd2f3201f2d9b9866b4c23fb0ebb3c3515feb944162fbbc1c5e31bfa8'
  checksum64     = 'a52cd052b006e14a0136d2e85bfb2f459d492ebda02931df5de215b769af0208'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '79.0.4143.72'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
