$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/58.0.3135.107/win/Opera_58.0.3135.107_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/58.0.3135.107/win/Opera_58.0.3135.107_Setup_x64.exe'
  checksum       = '481550e4745f18fd50901aefa8c66acacf1bd9d75fb08f55bd74f2d75378ce35'
  checksum64     = '82f1d6a847fe3372dd903c6048dfedf40dc70bae5c4963f8f2791ce37d580997'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '58.0.3135.107'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
