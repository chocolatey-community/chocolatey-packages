$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/94.0.4606.38/win/Opera_94.0.4606.38_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/94.0.4606.38/win/Opera_94.0.4606.38_Setup_x64.exe'
  checksum       = '1a9447e40eef154a9b19edcefed2f3ad4e997be814feaad13de0b0179cb1e9de'
  checksum64     = '8e9efb57e19a5ffd9090edde3cf1db67198b8f7f9227e0459eb3b502024c46df'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '94.0.4606.38'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
