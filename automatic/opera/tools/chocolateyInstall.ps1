$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/73.0.3856.284/win/Opera_73.0.3856.284_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/73.0.3856.284/win/Opera_73.0.3856.284_Setup_x64.exe'
  checksum       = '6a5ced54519713aa65ab761729c98945d5d3080f8e9250a0383f45b5305d0262'
  checksum64     = 'ab6f819445dd9aabce1b8be6ec31e5456ff7c99bc74184adf64d5bde204c4fa4'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '73.0.3856.284'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
