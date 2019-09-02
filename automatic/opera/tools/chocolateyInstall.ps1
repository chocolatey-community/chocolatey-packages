$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/63.0.3368.66/win/Opera_63.0.3368.66_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/63.0.3368.66/win/Opera_63.0.3368.66_Setup_x64.exe'
  checksum       = '8edbc4b0e4badd942361d3914f763044d84fcf7837f0a2e45d5a3ee660315909'
  checksum64     = 'e09c982c959b406c26256ae3b641e9e98b26ba3dfc021bf3d1641fc6889e21a9'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '63.0.3368.66'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
