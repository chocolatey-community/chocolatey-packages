$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/49.0.2725.39/win/Opera_49.0.2725.39_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/49.0.2725.39/win/Opera_49.0.2725.39_Setup_x64.exe'
  checksum       = '7e13f6e6f966d1a00167f2edb9ce75bd3f41d04b8fbdea98a996f627bfdaaecc'
  checksum64     = '44dcef541df90b3665a88091c504e56a3594a630534ea8d0f1f76f443dd6fcba'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0 /desktopshortcut 0 /pintotaskbar 0'
  validExitCodes = @(0)
}

$version = '49.0.2725.39'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
