$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

if (Is32BitInstalled) { $env:ChocolateyForceX86 = $true }

$version     = '47.0.2631.55'
$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/47.0.2631.55/win/Opera_47.0.2631.55_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/47.0.2631.55/win/Opera_47.0.2631.55_Setup_x64.exe'
  checksum       = '52abd1912c0710d8bfde103cba0d4cec4f9046b70680ca6c243903214412d9b2'
  checksum64     = '8445bb38a42a07008a9929e75a1ac6656f04a586b31e52367da62d91a17a8df7'
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
