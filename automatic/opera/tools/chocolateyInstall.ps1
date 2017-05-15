$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

if (Is32BitInstalled) { $env:ChocolateyForceX86 = $true }

$version     = '45.0.2552.812'
$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/45.0.2552.812/win/Opera_45.0.2552.812_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/45.0.2552.812/win/Opera_45.0.2552.812_Setup_x64.exe'
  checksum       = '8d27d8674a0c2a7477fb09a57362c582c2b10a3c843892b7361a81bca1c97be0'
  checksum64     = '960a17e17b9c9229f4dac72e9263870afc6cdd5e4889e7f5bafe1174171f9ffb'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0'
  validExitCodes = @(0)
}

if (IsVersionAlreadyInstalled $version) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
