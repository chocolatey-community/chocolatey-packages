$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/65.0.3467.72/win/Opera_65.0.3467.72_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/65.0.3467.72/win/Opera_65.0.3467.72_Setup_x64.exe'
  checksum       = '752a462b750cfd51c63be690b248a0fe3cb9223bfcbfc06519cb5bdfbf6d99ff'
  checksum64     = 'a196585724202645b37df7e0815cf6338ce6c5309ca378940879b4ede6db97ab'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '65.0.3467.72'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
