$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/57.0.3098.116/win/Opera_57.0.3098.116_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/57.0.3098.116/win/Opera_57.0.3098.116_Setup_x64.exe'
  checksum       = '6a4631a9056ccebbf0cdc7d66523d84b4b858235df85fbe566ece4d38961434b'
  checksum64     = '28330bada7fe2d3a7d46791f703e221bcf348444c6f7065e3004f019f1545a86'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '57.0.3098.116'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
