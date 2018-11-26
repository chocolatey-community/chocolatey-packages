$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/56.0.3051.116/win/Opera_56.0.3051.116_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/56.0.3051.116/win/Opera_56.0.3051.116_Setup_x64.exe'
  checksum       = 'fe9a7e3a60f40f6548b85ac1ae8b89a2bda5940d4328e2775ff769075e874521'
  checksum64     = 'abb304c3b719f078c45470e84ebaac188bca5214b1c0df03de7b291d58dc9ecd'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '56.0.3051.116'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
