$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/88.0.4412.40/win/Opera_88.0.4412.40_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/88.0.4412.40/win/Opera_88.0.4412.40_Setup_x64.exe'
  checksum       = '2bba1fcaafb0b33c34b1c061729e0afe7012cf6964a3704b69e65471757fe6f7'
  checksum64     = 'e167c1c75676f822c10b58fde36baf6ac2970700ee6640470903ea32d68628b9'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '88.0.4412.40'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
