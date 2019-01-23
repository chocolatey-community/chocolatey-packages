$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/58.0.3135.47/win/Opera_58.0.3135.47_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/58.0.3135.47/win/Opera_58.0.3135.47_Setup_x64.exe'
  checksum       = '96ff3336ddfb91c4925857d26afa0525b90644f1bb7b883d49895e738a9a4787'
  checksum64     = '227ba7799eedddec97833266226da224a3bdb0d8f8e5ac787396e0212a9613c2'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '58.0.3135.47'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
