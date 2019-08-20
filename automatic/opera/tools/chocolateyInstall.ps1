$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/63.0.3368.35/win/Opera_63.0.3368.35_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/63.0.3368.35/win/Opera_63.0.3368.35_Setup_x64.exe'
  checksum       = '64f454f364eee762a03cdb1b00b62d09502dadedb07a27624a8e32e0a2466bae'
  checksum64     = 'b43b3faa454afd3dbf00e24f25b16738f5afb7d3f732a83bf17ad55a77a40e4b'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '63.0.3368.35'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
