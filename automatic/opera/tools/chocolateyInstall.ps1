$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

if (Is32BitInstalled) { $env:ChocolateyForceX86 = $true }

$version     = '47.0.2631.80'
$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/47.0.2631.80/win/Opera_47.0.2631.80_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/47.0.2631.80/win/Opera_47.0.2631.80_Setup_x64.exe'
  checksum       = 'fce1710b6b4b666f2945e34a84a5c0676f9d5e1c3776cf337e12ebb0cd9e51e6'
  checksum64     = '8f3c6186eaa3eb833ec983ea3936daa2548ae9f28180f41d5452cba5080c217c'
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
