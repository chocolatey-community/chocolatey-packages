$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

if (Is32BitInstalled) { $env:ChocolateyForceX86 = $true }

$version     = '45.0.2552.898'
$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/45.0.2552.898/win/Opera_45.0.2552.898_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/45.0.2552.898/win/Opera_45.0.2552.898_Setup_x64.exe'
  checksum       = '6ae673e0f580dafedb513b28a0256c1928313d5ad02a846293363af9ae34563e'
  checksum64     = 'f92f1a7682dd2422dd44b752e58e2882e74a0d746c5f9d87e47f171fabe21838'
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
