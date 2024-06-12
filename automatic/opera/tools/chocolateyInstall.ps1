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
  url            = 'https://get.geo.opera.com/pub/opera/desktop/111.0.5168.25/win/Opera_111.0.5168.25_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/111.0.5168.25/win/Opera_111.0.5168.25_Setup_x64.exe'
  checksum       = '217cb0fb2df9ccada5c52950cb767228baf947a33491034e2a76e6e38b9b26f2'
  checksum64     = '8a2db505f9d9e17fd2b77054b4455f45db1ba1c73ef25c60a8766dab7012b5c0'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '111.0.5168.25'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
