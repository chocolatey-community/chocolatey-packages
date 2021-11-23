$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/81.0.4196.60/win/Opera_81.0.4196.60_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/81.0.4196.60/win/Opera_81.0.4196.60_Setup_x64.exe'
  checksum       = '59e483395c733dda13bd42e3b731b5098ac74bf51b530540c77e85fd9ddbd69c'
  checksum64     = '7503a19801652cc5c661bda8e2739be1d13849ccb232d056bff1f80ed21ad3a3'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '81.0.4196.60'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
