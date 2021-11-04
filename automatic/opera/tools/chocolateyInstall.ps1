$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/81.0.4196.31/win/Opera_81.0.4196.31_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/81.0.4196.31/win/Opera_81.0.4196.31_Setup_x64.exe'
  checksum       = '04723f840a35936a1c12d2648cf1b752a2b0812c84863d9280a73e8a625edc90'
  checksum64     = 'e6fdb78542d4c4b8275a95e2fc576db035b289c1c13960d6e4b9cd6c33ea449f'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '81.0.4196.31'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
