$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/60.0.3255.109/win/Opera_60.0.3255.109_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/60.0.3255.109/win/Opera_60.0.3255.109_Setup_x64.exe'
  checksum       = 'cb4de267b377798d498387d7e1c3341b128053ac9bd09989de3f8383c198ca48'
  checksum64     = 'd492c2b8fb423769db43c5b23f4ca2ce4237864cd7e77bdb76a0ae449e9ce2c3'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '60.0.3255.109'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
