$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/68.0.3618.173/win/Opera_68.0.3618.173_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/68.0.3618.173/win/Opera_68.0.3618.173_Setup_x64.exe'
  checksum       = 'e2fe2c3c65b5ea6cb6075081b22b9e29ac36cd51b06f99b4a6f6011384fdde3a'
  checksum64     = '5a9fb7a62ccfcbfdb15945d97d8caaaa42f7400494e5a9211db24f3ed45c7695'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '68.0.3618.173'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
