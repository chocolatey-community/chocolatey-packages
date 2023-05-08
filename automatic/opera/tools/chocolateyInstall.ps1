$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/98.0.4759.39/win/Opera_98.0.4759.39_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/98.0.4759.39/win/Opera_98.0.4759.39_Setup_x64.exe'
  checksum       = '8d494ff442f7fad857f2e256fa2f7b4c1aef142b21fabf89cbf383b2e9278faf'
  checksum64     = 'c1bc788a31b82d8a9ab00fa771da9c13ebc1f68c59576fbc453e646b9c3c747d'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '98.0.4759.39'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
