$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/77.0.4054.64/win/Opera_77.0.4054.64_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/77.0.4054.64/win/Opera_77.0.4054.64_Setup_x64.exe'
  checksum       = 'db3284ed19e9a1af03b45d47ab82e803c67fb3b2e5d0131d10fbaea80a9b6412'
  checksum64     = '54848d635ec94e4e365f7d6c09950039fb1259aea243550ce7e5d20c71ad7650'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '77.0.4054.64'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
