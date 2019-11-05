$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/64.0.3417.92/win/Opera_64.0.3417.92_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/64.0.3417.92/win/Opera_64.0.3417.92_Setup_x64.exe'
  checksum       = '694dae8a4dd8023ffa0fcd8ee048129a2f4505841a448cf0e7e72326fff16df1'
  checksum64     = '94d0985eff3fb00c209687ad165f5a265083ff3fd528d3c222ff1370c1d5d2f9'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '64.0.3417.92'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
