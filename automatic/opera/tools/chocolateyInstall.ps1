$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/67.0.3575.79/win/Opera_67.0.3575.79_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/67.0.3575.79/win/Opera_67.0.3575.79_Setup_x64.exe'
  checksum       = '19a60575bdfab5ae4fe9f1abba2a5399b5719e6914206fca73b454b3cd519e3a'
  checksum64     = '3c1db5fe63f91d0de56d04cd00c09b7566cc4d211badc27285e3b0eef636697c'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '67.0.3575.79'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
