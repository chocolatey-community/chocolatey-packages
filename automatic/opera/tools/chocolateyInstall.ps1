$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/83.0.4254.54/win/Opera_83.0.4254.54_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/83.0.4254.54/win/Opera_83.0.4254.54_Setup_x64.exe'
  checksum       = '218d85108040566557021e414ec53089dcce9c80c65e2ae3e22fa76ecc515dbd'
  checksum64     = '36ef5fd84454430fa2d74da90986352fb3f0b0ecd75c0d43180d6e6b501457e5'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '83.0.4254.54'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
