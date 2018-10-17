$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/56.0.3051.52/win/Opera_56.0.3051.52_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/56.0.3051.52/win/Opera_56.0.3051.52_Setup_x64.exe'
  checksum       = 'cd21fbdeea95f3d4c9a1d562d609ce6db73c874ce500e6fc539a209037d4fc1f'
  checksum64     = '7e5e5a1850bca8e50916064dd6a836ff5281e36527697a7748dc30f6fb97aafa'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '56.0.3051.52'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
