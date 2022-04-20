$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/85.0.4341.75/win/Opera_85.0.4341.75_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/85.0.4341.75/win/Opera_85.0.4341.75_Setup_x64.exe'
  checksum       = '9050b60a98911a917de2fb94e5484706bcd62887ca2d8ba199832ecbac8fd9d9'
  checksum64     = '4f3de0ea960ff824bbb55a7e1bc1992eaaac744e6443f951389b04e6e205220f'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '85.0.4341.75'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
