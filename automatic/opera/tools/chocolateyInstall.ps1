$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/54.0.2952.71/win/Opera_54.0.2952.71_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/54.0.2952.71/win/Opera_54.0.2952.71_Setup_x64.exe'
  checksum       = 'aa9e8c9c732ad4f9cb9335d9203a7a91ca24f2a9269a8b07accfacea2b7692ab'
  checksum64     = 'd6fd01e8d17fac1a20d6a4f8d4d600ac82a2720122d90f4d6e29d2142ba120d1'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '54.0.2952.71'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
