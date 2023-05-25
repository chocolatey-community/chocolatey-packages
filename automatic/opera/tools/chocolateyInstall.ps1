$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/99.0.4788.31/win/Opera_99.0.4788.31_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/99.0.4788.31/win/Opera_99.0.4788.31_Setup_x64.exe'
  checksum       = '7d34b79ca16c7862aabcb649e54abb1fb5373c09578316e1d15ab3007e3e0d31'
  checksum64     = 'b43f3e79421a2234634e756b5a671bfce28381cf1c3e517466804094c73aa795'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '99.0.4788.31'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
