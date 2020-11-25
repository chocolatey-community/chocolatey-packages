$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/72.0.3815.400/win/Opera_72.0.3815.400_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/72.0.3815.400/win/Opera_72.0.3815.400_Setup_x64.exe'
  checksum       = '43578aea78de99b8526870c7df7dcb3edd737a00cd55bbf164330fe90dbd792f'
  checksum64     = '07584ea951ced1d8fa0f8373ba05b9a79a0782e138d10fc68bf86f436b7d0337'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '72.0.3815.400'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
