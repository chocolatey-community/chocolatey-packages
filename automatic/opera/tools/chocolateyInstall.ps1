$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/92.0.4561.33/win/Opera_92.0.4561.33_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/92.0.4561.33/win/Opera_92.0.4561.33_Setup_x64.exe'
  checksum       = '997606d7c3fd96cea99593ecef88da7e6e0f5daeb10a63af983d4763d0bd8599'
  checksum64     = 'df5ac1d756bba7fa74a9ab8b9eabc5eead617890d9c74e201b523bc165534d2a'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '92.0.4561.33'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
