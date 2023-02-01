$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/95.0.4635.25/win/Opera_95.0.4635.25_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/95.0.4635.25/win/Opera_95.0.4635.25_Setup_x64.exe'
  checksum       = '027c79231ee5fcdd95fd62439c9ca677aed5f255a7b05ccbb7e4bb22cd1df5f0'
  checksum64     = 'a43164f99bb9f819b530381f6e6d089a9ea2e58cd0db04d85b07a42afa127797'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '95.0.4635.25'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
