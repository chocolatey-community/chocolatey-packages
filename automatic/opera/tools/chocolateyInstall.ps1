$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/76.0.4017.107/win/Opera_76.0.4017.107_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/76.0.4017.107/win/Opera_76.0.4017.107_Setup_x64.exe'
  checksum       = '308916bb762ba265664f143279f4bb3f95d2bf3b2b090c79822a665e88e4e83c'
  checksum64     = 'a5b68b2fda7a77438d1fa36fea43607c0ad0a23b6add75bd12f84b428a65aa81'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '76.0.4017.107'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
