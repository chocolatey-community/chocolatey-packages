$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/70.0.3728.189/win/Opera_70.0.3728.189_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/70.0.3728.189/win/Opera_70.0.3728.189_Setup_x64.exe'
  checksum       = '26dbfb4e43bf3b452852e48ab703a6c46e371441750a098d43306011d27b3b45'
  checksum64     = 'ba9257c71136e8f1c0a3a386b2182f6f237d4bdcfc33660e3148b3da7e25bbca'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '70.0.3728.189'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
