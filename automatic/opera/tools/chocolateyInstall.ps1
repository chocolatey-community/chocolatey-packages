$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/89.0.4447.83/win/Opera_89.0.4447.83_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/89.0.4447.83/win/Opera_89.0.4447.83_Setup_x64.exe'
  checksum       = '232586ae64b6e8c0bfcabbcc3c0d5136264fd70420290778f62fdf3026738356'
  checksum64     = '17451165fdac87aa25e62504c0c06fdd27628e98e4dbf017aaeb4af14cd369ef'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '89.0.4447.83'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
