$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/72.0.3815.207/win/Opera_72.0.3815.207_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/72.0.3815.207/win/Opera_72.0.3815.207_Setup_x64.exe'
  checksum       = '3e981fbe6e2c5a38448892a01afd74ec03ad5747757ece9f7f6643361d9134b1'
  checksum64     = '570f0376e50c5ac81bc21002ff6f61a1534b5f3fd5bfbbc0ca9e85bc2b4b489a'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '72.0.3815.207'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
