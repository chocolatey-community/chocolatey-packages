$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/84.0.4316.42/win/Opera_84.0.4316.42_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/84.0.4316.42/win/Opera_84.0.4316.42_Setup_x64.exe'
  checksum       = '764ab82807ec7681cf773ced0a0c852f4ce4fdfc063558a81c4ca0a9e4d3efbf'
  checksum64     = '8937237644fea9a97b1822a1c844bc813f3ab1432341fd567212a063b7693c41'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '84.0.4316.42'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
