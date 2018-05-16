$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/53.0.2907.57/win/Opera_53.0.2907.57_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/53.0.2907.57/win/Opera_53.0.2907.57_Setup_x64.exe'
  checksum       = '28f4f0415715d233ae7418c136d7fda91c8d6146324204c75f8bf99ed5b17d17'
  checksum64     = '516809abfc8f02573fe387e6d3286f5449a777e4611ed7521b2c912a19645016'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0'
  validExitCodes = @(0)
}

$version = '53.0.2907.57'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
