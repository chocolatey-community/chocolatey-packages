$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/77.0.4054.277/win/Opera_77.0.4054.277_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/77.0.4054.277/win/Opera_77.0.4054.277_Setup_x64.exe'
  checksum       = 'a60a9e99444b4faea76b74fd8b8a9598118375a58bccf5ed7e7182a9ff8ddebe'
  checksum64     = '8f47eab8e0bd90562eefe6ba89db36dbbe01622056a02a4cc6e8d53244a46e30'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '77.0.4054.277'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
