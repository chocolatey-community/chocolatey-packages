$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/58.0.3135.118/win/Opera_58.0.3135.118_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/58.0.3135.118/win/Opera_58.0.3135.118_Setup_x64.exe'
  checksum       = '4eeafa822cd79a10e4c0b943d1ba6d446daba5240ff8cc1122eacc196b96c568'
  checksum64     = '3abc225fa92ff98be1d61ece4ea9c37a47d2ca8f103a13ad0a3c7e59ba91ade6'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '58.0.3135.118'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
