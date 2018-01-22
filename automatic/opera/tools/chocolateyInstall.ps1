$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/50.0.2762.67/win/Opera_50.0.2762.67_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/50.0.2762.67/win/Opera_50.0.2762.67_Setup_x64.exe'
  checksum       = 'd9741faefc574a5c3c99d9a1e788de9a26ddda06a8f469764d6bead09ab69e97'
  checksum64     = 'cb9f466732abfea1460c0881caf41d262bbe216ace66d61ddb7682088a35046a'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0'
  validExitCodes = @(0)
}

$version = '50.0.2762.67'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
