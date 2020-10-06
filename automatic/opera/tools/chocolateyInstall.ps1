$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/71.0.3770.228/win/Opera_71.0.3770.228_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/71.0.3770.228/win/Opera_71.0.3770.228_Setup_x64.exe'
  checksum       = '4391b174355a4d0dc7f2ca4248b140e5608af14bed8dcd319a3e0c13b9bc9e21'
  checksum64     = '577870c1693cb67a75ac74d30d1b2b7fb7831bc3a540291edc48330556070ba6'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '71.0.3770.228'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
