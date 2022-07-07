$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/89.0.4447.38/win/Opera_89.0.4447.38_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/89.0.4447.38/win/Opera_89.0.4447.38_Setup_x64.exe'
  checksum       = 'a99ba9fd6fab7d25ef0016932cbd6b74c2904aea188b5fa00bf0fc6afc156f37'
  checksum64     = '37a56ac0f714ed73853f86e85776c214d8177258e6350c144ab6363aaca2e489'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '89.0.4447.38'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
