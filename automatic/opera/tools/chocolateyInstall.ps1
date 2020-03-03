$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/67.0.3575.53/win/Opera_67.0.3575.53_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/67.0.3575.53/win/Opera_67.0.3575.53_Setup_x64.exe'
  checksum       = '8af5da925d3e59f522f8d3848617cee4f8fcb9dda14d3e529bf713ab50c59343'
  checksum64     = 'c3e5d5a516e8f34d0c748cd911fa327194597d4d8777e377d52b3da7816f2cf6'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '67.0.3575.53'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
