$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/48.0.2685.39/win/Opera_48.0.2685.39_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/48.0.2685.39/win/Opera_48.0.2685.39_Setup_x64.exe'
  checksum       = '0ced493b5c3aed9c25d45ebcda7e589166e8a21d3578d581a5ef1bb0554e0f96'
  checksum64     = '537fc1270d5dbcb515782c122dc417ac124ebd78dd2fed229fde7a5fc6b71298'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0'
  validExitCodes = @(0)
}

$version = '48.0.2685.39'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
