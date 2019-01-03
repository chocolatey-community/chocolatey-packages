$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/57.0.3098.110/win/Opera_57.0.3098.110_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/57.0.3098.110/win/Opera_57.0.3098.110_Setup_x64.exe'
  checksum       = '6592487137d38ac684a60e96abd1327c12f1f975d8ba21b2949df17d010b8945'
  checksum64     = 'daf516c1129a38c8739030e1e5f464adb1823a696a76dc0291ae4d00b06a077c'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '57.0.3098.110'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
