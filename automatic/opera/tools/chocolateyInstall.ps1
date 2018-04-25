$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/52.0.2871.97/win/Opera_52.0.2871.97_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/52.0.2871.97/win/Opera_52.0.2871.97_Setup_x64.exe'
  checksum       = '84b102c1d2430b8f66280ee4a611e691812fcf2d53e6f77878208090aefd5618'
  checksum64     = '667664173084d0c8c66d7d585f2876004b3501777e9fd64595641cc8f5c76b72'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0'
  validExitCodes = @(0)
}

$version = '52.0.2871.97'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
