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
  url            = 'https://get.geo.opera.com/pub/opera/desktop/120.0.5543.161/win/Opera_120.0.5543.161_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/120.0.5543.161/win/Opera_120.0.5543.161_Setup_x64.exe'
  checksum       = '22c18bfb13ae9cbf6ad912163096ff393ade56199adb8805de132052fcd07ae4'
  checksum64     = 'f342148612b3292e461508b30291d0efcd051d37dca1780ef22f696203eac870'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '120.0.5543.161'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
