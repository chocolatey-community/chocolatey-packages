$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/79.0.4143.50/win/Opera_79.0.4143.50_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/79.0.4143.50/win/Opera_79.0.4143.50_Setup_x64.exe'
  checksum       = '748236e42fae9d132bf2afde7bdf2d0f3b270ab7ee6bdb2badcd8d28091e5f00'
  checksum64     = '9ac4ead834f9dc0b7b30c558f8ec63f6f171380309786dfa2a9b23c0cc348311'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '79.0.4143.50'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
