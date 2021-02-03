$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/74.0.3911.75/win/Opera_74.0.3911.75_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/74.0.3911.75/win/Opera_74.0.3911.75_Setup_x64.exe'
  checksum       = 'f9c889f29405b75288a54fd7b1a43389d2c96093a753723bf00e9a5513ebb48d'
  checksum64     = 'fa8ec74a29175415ba729281102b94942255eeb42d5c31a6106dfe7353bdb5ab'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '74.0.3911.75'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
