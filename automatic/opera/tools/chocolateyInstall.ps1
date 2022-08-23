$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/90.0.4480.54/win/Opera_90.0.4480.54_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/90.0.4480.54/win/Opera_90.0.4480.54_Setup_x64.exe'
  checksum       = '73e941126b95c5e9d4195a25d984030201dafe5fc3403420f0f1ae96a06b3fec'
  checksum64     = 'c1958ed651dd1d6e575cdfa7940dc50c33e136e385dce071b9efb033e32dc381'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '90.0.4480.54'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
