$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/80.0.4170.63/win/Opera_80.0.4170.63_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/80.0.4170.63/win/Opera_80.0.4170.63_Setup_x64.exe'
  checksum       = '3f22705c5bdf48033d5588fc1212b06b3f15093e553b41c2b10a248a821ed307'
  checksum64     = '35e512103dbff26670ce53bb4335a8851e4d4faa05d6e2c032546395a3357e67'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '80.0.4170.63'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
