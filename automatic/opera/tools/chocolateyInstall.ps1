$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/58.0.3135.53/win/Opera_58.0.3135.53_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/58.0.3135.53/win/Opera_58.0.3135.53_Setup_x64.exe'
  checksum       = 'fc7d8f0f42fc2ed5807cb9410518bc59c4490f61504e09899c521879def6872b'
  checksum64     = 'a4bba92da6975f249ce33e1e476a1d7c567912c2c5b7b2eca2296d67c47c6562'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '58.0.3135.53'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
