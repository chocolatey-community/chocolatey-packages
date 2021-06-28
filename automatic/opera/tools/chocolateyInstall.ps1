$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/77.0.4054.146/win/Opera_77.0.4054.146_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/77.0.4054.146/win/Opera_77.0.4054.146_Setup_x64.exe'
  checksum       = '4513db1f1a68cb2eff48c7ac112c9424191f6e2e576da5816833ff232a664309'
  checksum64     = '4d30d80a13cab2f13421617b533c3d1ce5dbe8d8307dd1202560f4d4358bba5f'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '77.0.4054.146'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
