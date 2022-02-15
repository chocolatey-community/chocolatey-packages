$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/83.0.4254.62/win/Opera_83.0.4254.62_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/83.0.4254.62/win/Opera_83.0.4254.62_Setup_x64.exe'
  checksum       = '00e524da86b116d48077c17bc70ad0dfe6d39e0018143e93a06cdb377d269751'
  checksum64     = 'de8deffabdbe5b383714f691502a6536bd2a67a9aa3c7634c76bcfcf1350c343'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '83.0.4254.62'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
