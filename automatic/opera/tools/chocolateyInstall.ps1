$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/89.0.4447.48/win/Opera_89.0.4447.48_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/89.0.4447.48/win/Opera_89.0.4447.48_Setup_x64.exe'
  checksum       = '44c1f2b4be4fa286a4e36b4019e68fd441630897d51034e00c1caeeca3a21f29'
  checksum64     = 'ca7905cb412010375cba85e7fcc3649a37e316072c11dc7c45562a9e52ef0e21'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '89.0.4447.48'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
