$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/48.0.2685.32/win/Opera_48.0.2685.32_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/48.0.2685.32/win/Opera_48.0.2685.32_Setup_x64.exe'
  checksum       = 'f7d48c4712415e677474fb9fa2e371e3cd387050fcc099d247bde6fe186520db'
  checksum64     = 'a243d7465968b49568c867982cdaeed4b70ac24866cbb97e7d089faf2f49f636'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0'
  validExitCodes = @(0)
}

if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $Env:ChocolateyPackageVersion)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
