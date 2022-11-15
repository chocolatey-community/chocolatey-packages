$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/92.0.4561.61/win/Opera_92.0.4561.61_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/92.0.4561.61/win/Opera_92.0.4561.61_Setup_x64.exe'
  checksum       = 'f0392c96c190ba26342f28d34b00837c79f0f6bb50257eb7223e6242a86ae1d3'
  checksum64     = 'af0f1586ada0009dcc5ea0994ea3492b4fa71ccf90c61febe3a2f6cc0f6ca1a9'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '92.0.4561.61'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
