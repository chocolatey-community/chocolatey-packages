$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/96.0.4693.80/win/Opera_96.0.4693.80_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/96.0.4693.80/win/Opera_96.0.4693.80_Setup_x64.exe'
  checksum       = 'fe8d07f18d2a465882c63ca0d9794e4a549a498c8b310bdaded14f30814e9b74'
  checksum64     = '53eec28bf55869c1e4fe8cb18a791492bc1aab44d1748c33b1826742d6ed1c85'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '96.0.4693.80'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
