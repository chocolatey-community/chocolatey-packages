$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

if (Is32BitInstalled) { $env:ChocolateyForceX86 = $true }

$version     = '47.0.2631.39'
$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/47.0.2631.39/win/Opera_47.0.2631.39_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/47.0.2631.39/win/Opera_47.0.2631.39_Setup_x64.exe'
  checksum       = '0b82fdcbff3aaa890569c2a0a6d1b7c8cdf4dabb6db62eee6e97aec01015ee0e'
  checksum64     = '65e35846b0d1f47d5f442036e336333ebf2a059b2e23747299d8494d255170d0'
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
