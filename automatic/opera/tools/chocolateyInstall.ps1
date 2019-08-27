$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/63.0.3368.53/win/Opera_63.0.3368.53_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/63.0.3368.53/win/Opera_63.0.3368.53_Setup_x64.exe'
  checksum       = '1ff117ec7d08fad2c1bc9e17ae2dcfea10b8ea29c55b6e797a1012050bc2096f'
  checksum64     = '09f10f39e3fe3e62f31ca3d3e6e5870e2d48e21507961a28ab2d6c2109b4e4c4'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '63.0.3368.53'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
