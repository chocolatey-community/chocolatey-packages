$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/62.0.3331.72/win/Opera_62.0.3331.72_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/62.0.3331.72/win/Opera_62.0.3331.72_Setup_x64.exe'
  checksum       = '05c371c5f74bdf2bd18bf48a2fedf03680acd4ca19de17cdc0a6d0d84f40afac'
  checksum64     = 'e79df558e329f8b080bcf243524612bc9b263dbcc7917b12420db66be8acd49b'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '62.0.3331.72'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
