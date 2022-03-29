$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/85.0.4341.28/win/Opera_85.0.4341.28_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/85.0.4341.28/win/Opera_85.0.4341.28_Setup_x64.exe'
  checksum       = '6435afd5d3b7ef10aa2697a0ee7a4d7d1a276a54f73ba6f4bd5f7bd84226e041'
  checksum64     = 'd5cc0cbee1fca8928e00c8882d6c67247824b89e9dbed4350b218b390b210485'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '85.0.4341.28'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
