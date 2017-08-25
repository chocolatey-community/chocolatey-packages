$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

if (Is32BitInstalled) { $env:ChocolateyForceX86 = $true }

$version     = '47.0.2631.71'
$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/47.0.2631.71/win/Opera_47.0.2631.71_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/47.0.2631.71/win/Opera_47.0.2631.71_Setup_x64.exe'
  checksum       = '8db414ee098b0b94c729c0eedaaf4df65c3cac3c43bdab515ee6a8e47a3733cf'
  checksum64     = 'a8f1524ad386b24d3f4253bb20337c47db5de9c73eb6f0e711e8c909f6393b55'
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
