$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/54.0.2952.41/win/Opera_54.0.2952.41_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/54.0.2952.41/win/Opera_54.0.2952.41_Setup_x64.exe'
  checksum       = '2ddbf394df1bfaf91286faff8ff47470c704000c1f777c47a79dd754ebfbe31f'
  checksum64     = 'f9c6e69a5c19721816504cfbe6fb6b2aac46a81fdc2edcc54b19fb45a06a0b39'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '54.0.2952.41'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
