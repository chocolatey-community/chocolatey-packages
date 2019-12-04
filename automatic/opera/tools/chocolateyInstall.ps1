$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/65.0.3467.62/win/Opera_65.0.3467.62_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/65.0.3467.62/win/Opera_65.0.3467.62_Setup_x64.exe'
  checksum       = '568732d3e1b8b5a06f08d6037cd8417831b858161b97bfcb6803d95739f896de'
  checksum64     = '6d3aea09509f0494758b4f5a5430f31aaff3ee4a80d32c4304b91f8a17d6f4c6'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '65.0.3467.62'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
