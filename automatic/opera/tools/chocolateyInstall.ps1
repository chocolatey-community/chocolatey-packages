$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/52.0.2871.99/win/Opera_52.0.2871.99_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/52.0.2871.99/win/Opera_52.0.2871.99_Setup_x64.exe'
  checksum       = '653ad755eab5a89546bfd7edf6c3d7649f810553c449be406c5b436a1a24bc98'
  checksum64     = 'eb8a6be4353a51c7c7e9ce9834a5738ce50dfbf77d219f240a051eb2a117b4d5'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0'
  validExitCodes = @(0)
}

$version = '52.0.2871.99'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
