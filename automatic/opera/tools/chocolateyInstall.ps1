$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/53.0.2907.99/win/Opera_53.0.2907.99_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/53.0.2907.99/win/Opera_53.0.2907.99_Setup_x64.exe'
  checksum       = '22fb3a8d2135c02efe1e5f0c517cc476935ae48106a61c5b15ed9ef16ef10ad1'
  checksum64     = '77dec38f1cc2cc8b413dc27fbc627af5766c3cb78801074cb966e938c93fd13d'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '53.0.2907.99'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
