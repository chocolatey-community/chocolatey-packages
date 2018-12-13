$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/57.0.3098.102/win/Opera_57.0.3098.102_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/57.0.3098.102/win/Opera_57.0.3098.102_Setup_x64.exe'
  checksum       = '72d5ea3b83f5024bb30f9554ffcedd846c7f27e2488e00921f96a7f2a3ca492b'
  checksum64     = 'eb4d11e4de574dd383ac3e7a023d1581ade1ec10d1738766ed9a86919acf463f'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '57.0.3098.102'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
