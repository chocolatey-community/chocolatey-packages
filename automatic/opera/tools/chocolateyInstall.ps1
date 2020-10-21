$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/72.0.3815.148/win/Opera_72.0.3815.148_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/72.0.3815.148/win/Opera_72.0.3815.148_Setup_x64.exe'
  checksum       = 'bcdaf84851af4c6c552aa5a7203d77d67e02c255ce85ec1fa221bc66fe3419c9'
  checksum64     = '13f158597bdc118ddbba8beaa754e633dbec7b46eda8b9069e5cea39365eae27'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '72.0.3815.148'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
