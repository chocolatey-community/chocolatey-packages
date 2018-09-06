$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/55.0.2994.56/win/Opera_55.0.2994.56_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/55.0.2994.56/win/Opera_55.0.2994.56_Setup_x64.exe'
  checksum       = 'ee2903c57428ab89583892a95400f9a763ceb1a058fa368a3948b501f2f927b6'
  checksum64     = '235789ad36f9cdff02364775530f082d3d2b58d18a3c7039fcdb300674c11a4a'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '55.0.2994.56'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
