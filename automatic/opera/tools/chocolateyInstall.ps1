$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/70.0.3728.144/win/Opera_70.0.3728.144_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/70.0.3728.144/win/Opera_70.0.3728.144_Setup_x64.exe'
  checksum       = 'd3fc0dc3cd35f5ccc8a54d32aaff3430ee52de578edf432165d08d89940ac38c'
  checksum64     = '620f49b83b792598260335073aae96418a3787e54c397c59de6d2a855b8531e0'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '70.0.3728.144'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
