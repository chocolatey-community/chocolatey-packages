$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/94.0.4606.76/win/Opera_94.0.4606.76_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/94.0.4606.76/win/Opera_94.0.4606.76_Setup_x64.exe'
  checksum       = '4903c743f8fb439659b74fc00dfd8ededda1d6f61d6381216c1a7b555044b0a2'
  checksum64     = '9f9868d2468627ae11c92d22fb90cb263a54489f739dc5b6da1c4336f3de6456'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '94.0.4606.76'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
