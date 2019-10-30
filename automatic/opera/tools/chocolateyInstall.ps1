$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/64.0.3417.83/win/Opera_64.0.3417.83_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/64.0.3417.83/win/Opera_64.0.3417.83_Setup_x64.exe'
  checksum       = '329b5c70c5ba50a7117a7eaea6ce268d225922bd6eadfe25ebb923f41c595916'
  checksum64     = '7b930d6c1d623a3ba37f1fbbf29d68d9596faf897a23209bec51976eaa3c3492'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '64.0.3417.83'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
