$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/75.0.3969.171/win/Opera_75.0.3969.171_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/75.0.3969.171/win/Opera_75.0.3969.171_Setup_x64.exe'
  checksum       = 'ccd6e4f57abbc01b7cdf24002b9044be2bf0f2825f786a832840d5864fcde739'
  checksum64     = '8942a63544796e9c2c62ced23ac9bc17a53d972ed1593c53d13854ef8fcb5622'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '75.0.3969.171'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
