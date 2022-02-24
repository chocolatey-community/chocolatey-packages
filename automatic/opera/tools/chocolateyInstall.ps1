$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/84.0.4316.21/win/Opera_84.0.4316.21_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/84.0.4316.21/win/Opera_84.0.4316.21_Setup_x64.exe'
  checksum       = 'e47f2188f5b43e0891018b6c76ca520001d4b9ecd44066fe0eb92ef51589adce'
  checksum64     = '1b8d54bd8636c28dc06979f3ef2d8109cbf51907b316d3ded9e81241612e537c'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '84.0.4316.21'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
