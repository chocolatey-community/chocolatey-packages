$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

if (Is32BitInstalled) { $env:ChocolateyForceX86 = $true }

$version     = '46.0.2597.32'
$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/46.0.2597.32/win/Opera_46.0.2597.32_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/46.0.2597.32/win/Opera_46.0.2597.32_Setup_x64.exe'
  checksum       = '74977b0da0219d646ef8c34d9cbb15e96a1ed76c2a44bb3d25b70f4e9920b44f'
  checksum64     = 'f87f091f5eda0cd68390edd18b413e4625ae4bf983fa2b4ba423f9689de571a2'
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
