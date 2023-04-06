$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/97.0.4719.63/win/Opera_97.0.4719.63_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/97.0.4719.63/win/Opera_97.0.4719.63_Setup_x64.exe'
  checksum       = 'ae5fcbca683b7613bbabe9d14dc9eb11dea503722239c1b8dcf011f68d309012'
  checksum64     = '88f90bd6f73501f14dd5bda1f56f62cf420505f19a3c0a957b3fd8b7d61ddde6'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '97.0.4719.63'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
