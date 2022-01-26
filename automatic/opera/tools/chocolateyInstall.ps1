$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/83.0.4254.27/win/Opera_83.0.4254.27_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/83.0.4254.27/win/Opera_83.0.4254.27_Setup_x64.exe'
  checksum       = '737e901e679e438cbabd6472935058ff46b0a879aa72f2ebc7c3c3edf6531846'
  checksum64     = '6cde22ae9b56e1a9e3a01d1554aa241c152f6c53b9e33a94b7f35968617efec0'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '83.0.4254.27'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
