$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/55.0.2994.37/win/Opera_55.0.2994.37_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/55.0.2994.37/win/Opera_55.0.2994.37_Setup_x64.exe'
  checksum       = '14656af19555a5d6f3658a9ef832afa3854c8260b94a14ee7f8a3be83cea7d96'
  checksum64     = '7ed94e2e5a516eeae2245cd5766122b43e316dd202f020a11d85167881806001'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '55.0.2994.37'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
