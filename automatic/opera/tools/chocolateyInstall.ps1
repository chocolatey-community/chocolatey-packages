$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/82.0.4227.58/win/Opera_82.0.4227.58_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/82.0.4227.58/win/Opera_82.0.4227.58_Setup_x64.exe'
  checksum       = 'a7a7a12b3e9d3abe80cfda81ebd31470ad5cad9c92c0c345bfe3d00b5c575d6f'
  checksum64     = 'e87838a058c003ae24b6c69057804d733083608bbed3c0fb71c64f2b9f821c76'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '82.0.4227.58'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
