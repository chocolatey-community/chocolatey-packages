$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/78.0.4093.147/win/Opera_78.0.4093.147_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/78.0.4093.147/win/Opera_78.0.4093.147_Setup_x64.exe'
  checksum       = 'f5b142711d9b45f56cbaa6b40a60c9a6d16c6a990397627f563b44d1d7947353'
  checksum64     = '5c37f84a3faabfa49b09ad4a29529b2698697c466793a44ca5d38f8fa7199dc7'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '78.0.4093.147'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
