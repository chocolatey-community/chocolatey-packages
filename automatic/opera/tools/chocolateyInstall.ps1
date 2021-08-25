$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/78.0.4093.184/win/Opera_78.0.4093.184_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/78.0.4093.184/win/Opera_78.0.4093.184_Setup_x64.exe'
  checksum       = '20204691b694109ecc55f9ed6406bbf94c8a19167daf054d786e2ecf46c8841f'
  checksum64     = 'fbe937dc190307bcbfa662932b52e8722c16d55153e969c36e245d8ddc7904f3'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '78.0.4093.184'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
