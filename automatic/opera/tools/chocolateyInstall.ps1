$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/56.0.3051.88/win/Opera_56.0.3051.88_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/56.0.3051.88/win/Opera_56.0.3051.88_Setup_x64.exe'
  checksum       = '79f574d867067b75f599b75f51c33224a83ef67dec360d8a7ad08b9b70f1bfc7'
  checksum64     = '61139610defe75a47c8568f8bd70e0dd2212df23d715bbdec57f1e4181eaee9a'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '56.0.3051.88'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
