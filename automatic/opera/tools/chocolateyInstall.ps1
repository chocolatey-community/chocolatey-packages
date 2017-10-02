$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/48.0.2685.35/win/Opera_48.0.2685.35_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/48.0.2685.35/win/Opera_48.0.2685.35_Setup_x64.exe'
  checksum       = '031a31712eb27a3ff0a67117a8a2e66db2bcf990e3b95ff2042e3ba93c42eb7b'
  checksum64     = '8ddda81b9f7c390cfa2075bb9aa2c2fc255753c2803d0c4f5508b22b14fd7515'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0'
  validExitCodes = @(0)
}

$version = '48.0.2685.35'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
