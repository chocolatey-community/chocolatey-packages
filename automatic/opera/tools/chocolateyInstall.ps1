$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/93.0.4585.11/win/Opera_93.0.4585.11_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/93.0.4585.11/win/Opera_93.0.4585.11_Setup_x64.exe'
  checksum       = '7267f2a554d9996239a3928c9c90225e11cd5a0439b170c753ef563d74c2ae90'
  checksum64     = '87e488530b0ad1031e59ab330d7bacc6fc9c6166362bb934be7238ad41b14d46'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '93.0.4585.11'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
