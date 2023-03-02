$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/96.0.4693.31/win/Opera_96.0.4693.31_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/96.0.4693.31/win/Opera_96.0.4693.31_Setup_x64.exe'
  checksum       = '8d97d1fc365644b48105bb1b5476162eee89d17f28116fa8798778921928c62b'
  checksum64     = '0a1b67f837e8a92f43f5af1f4cb73d1e3da61491b6a379a7686a709f1747f21b'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '96.0.4693.31'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
