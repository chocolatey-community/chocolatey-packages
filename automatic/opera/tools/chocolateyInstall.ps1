$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/79.0.4143.22/win/Opera_79.0.4143.22_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/79.0.4143.22/win/Opera_79.0.4143.22_Setup_x64.exe'
  checksum       = 'f35c2bb3fe5115af45bd6c413d880079a03d101645f9deba11759cdf683d3a9e'
  checksum64     = '6420bb8eb41c2f7afd14baaaedcfec7ddc3bd015d7ae83e8b9d19a2579214fdd'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '79.0.4143.22'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
