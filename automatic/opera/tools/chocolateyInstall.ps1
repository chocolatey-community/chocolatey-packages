$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/100.0.4815.21/win/Opera_100.0.4815.21_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/100.0.4815.21/win/Opera_100.0.4815.21_Setup_x64.exe'
  checksum       = '6d39aa068c371917fa4b0dbc0847d2702f4006b83d733a5c99d79bcf98a7ef29'
  checksum64     = '1dd0cccbae2eb1ce4f8ffe040c69b20fb665cc5ddd3f07b1f9a9caa93638544a'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '100.0.4815.21'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
