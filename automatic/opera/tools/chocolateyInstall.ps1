$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/65.0.3467.42/win/Opera_65.0.3467.42_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/65.0.3467.42/win/Opera_65.0.3467.42_Setup_x64.exe'
  checksum       = '6e67d3a6e3012160e76decbc88357f29fac369d2c53d141ce02b6b4a108fc0dc'
  checksum64     = '05e19ec627d7f3ec7c4a0b585f887331fbfce799fb51fc669d1251b87f68d814'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '65.0.3467.42'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
