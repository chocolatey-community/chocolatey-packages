$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/53.0.2907.88/win/Opera_53.0.2907.88_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/53.0.2907.88/win/Opera_53.0.2907.88_Setup_x64.exe'
  checksum       = 'fb1c7fb42f0139bb2fc2898e5e9a7f34e8972abeef1673aca2033060927e9205'
  checksum64     = '372b475380cdf1e401a5f61b0636d913a72f10b72e3a8531d8c305a978d9783d'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '53.0.2907.88'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
