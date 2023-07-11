$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/100.0.4815.54/win/Opera_100.0.4815.54_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/100.0.4815.54/win/Opera_100.0.4815.54_Setup_x64.exe'
  checksum       = '374b2afcfde334fc0a1eef7c564f4850461ae3f597db0777a8256d4fa1af22dd'
  checksum64     = 'dd95bef9bb4a91d52e5859aa571de9a636d8259c7c3440488766bbb5b75fe2c3'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '100.0.4815.54'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
