$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/69.0.3686.57/win/Opera_69.0.3686.57_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/69.0.3686.57/win/Opera_69.0.3686.57_Setup_x64.exe'
  checksum       = '1a513674cedc13f160778c17a0cdf2cb855ec03f15b3f134db250da9edebb1a4'
  checksum64     = 'aad1af58e30bfb03dffbe6922508a22f12efe53ab3088e21a182748153de16c8'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '69.0.3686.57'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
