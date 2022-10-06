$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/91.0.4516.65/win/Opera_91.0.4516.65_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/91.0.4516.65/win/Opera_91.0.4516.65_Setup_x64.exe'
  checksum       = 'd0eda5e00346ca6b489270fa6c73276fabb5f991a910e1009ff58f47708a52ea'
  checksum64     = 'c86f3e8d54aff54404d6771d51171ac95446d99f14595d5b7442cad8ae7da10a'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '91.0.4516.65'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
