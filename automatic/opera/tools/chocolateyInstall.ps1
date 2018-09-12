$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/55.0.2994.59/win/Opera_55.0.2994.59_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/55.0.2994.59/win/Opera_55.0.2994.59_Setup_x64.exe'
  checksum       = 'fa295e369d31bd48ae7b4f5edd24e827ebba801c4aad16bcbcec9d864ecddbd8'
  checksum64     = '56fa4b8baf2a34feab1fd26f7a95eca602b0de9559b06a12e33d964419a42d27'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '55.0.2994.59'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
