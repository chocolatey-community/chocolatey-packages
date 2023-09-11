$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoAutostart) { " /run-at-startup=0"; Write-Host "Autorun entry won't be added" }
$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/102.0.4880.46/win/Opera_102.0.4880.46_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/102.0.4880.46/win/Opera_102.0.4880.46_Setup_x64.exe'
  checksum       = '3a2d7482a7b3a9900149c1f1dfce389f5622cba161a8e8e89f9530cc943cdac0'
  checksum64     = 'cbadc5e7aa1336bdea7da35bf0389749a1ad590d1c9cc423e97f808c406df6f2'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '102.0.4880.46'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
