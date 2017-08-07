$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

if (Is32BitInstalled) { $env:ChocolateyForceX86 = $true }

$version     = '46.0.2597.61'
$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/46.0.2597.61/win/Opera_46.0.2597.61_i386_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/46.0.2597.61/win/Opera_46.0.2597.61_x64_Setup.exe'
  checksum       = '039fcbe3ddc49c12c39558b8f130562b9536aeedde0d9bb383422e194673dec5'
  checksum64     = 'e3b74a0ce87f8e1e69d869e37fa2175a36b4476309aa89c341c2e8ab43334cf6'
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
