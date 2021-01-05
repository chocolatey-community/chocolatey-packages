$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/73.0.3856.329/win/Opera_73.0.3856.329_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/73.0.3856.329/win/Opera_73.0.3856.329_Setup_x64.exe'
  checksum       = 'f39790bb020cd2cbb5f79ec0d8d7cbabe9ba521f4b0905c3bf2bdb3f457f6a75'
  checksum64     = '4edce23c2e26f75bf7dd0c2add82e9a9d0bc9afbb7900b54151676b352bc2eac'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '73.0.3856.329'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
