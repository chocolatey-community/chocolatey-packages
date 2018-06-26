$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/53.0.2907.110/win/Opera_53.0.2907.110_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/53.0.2907.110/win/Opera_53.0.2907.110_Setup_x64.exe'
  checksum       = 'cfc9c3653c91dc907870a68e12782be276f45564c3f43662a03c20b32b275883'
  checksum64     = 'a996187b7e6b5a0bd4a9109233eb15e5f2ee107eb58424749e13367b6f437d1b'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '53.0.2907.110'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
