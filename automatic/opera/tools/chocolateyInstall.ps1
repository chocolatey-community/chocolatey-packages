$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/62.0.3331.18/win/Opera_62.0.3331.18_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/62.0.3331.18/win/Opera_62.0.3331.18_Setup_x64.exe'
  checksum       = '5c6154bf91b4b37e3959c04db4cd9b3f2aa53531f9965ec5a960890dcc5f35ff'
  checksum64     = '1e680b2da54fa52466d181b1c29e73e2fe2415cbb6b6909854c2ff0ada36d3b9'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '62.0.3331.18'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
