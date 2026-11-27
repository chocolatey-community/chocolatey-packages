$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoAutostart) { " /run-at-startup=0"; Write-Host "Autorun entry won't be added" }
$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/141.0.6089.33/win/Opera_141.0.6089.33_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/141.0.6089.33/win/Opera_141.0.6089.33_Setup_x64.exe'
  checksum       = '93a97a460257a6c64671d8310e990ed5cbc57f4000256ed610a51fe1a9775d39'
  checksum64     = '744f435f9b7c60df73aac9d60bb09e4d8abb91d28e080e2b323ba6b172d6057d'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '141.0.6089.33'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
