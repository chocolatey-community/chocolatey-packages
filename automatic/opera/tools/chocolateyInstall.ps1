$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/77.0.4054.60/win/Opera_77.0.4054.60_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/77.0.4054.60/win/Opera_77.0.4054.60_Setup_x64.exe'
  checksum       = '908067ab263383015abfa8784ec411ade7e25ddb7ca903c77ede67ebf49569db'
  checksum64     = '7647656c2f79e1bccbf7e0f7cbc10d222904a17f27ca247d6bde6c4b015f8c4f'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '77.0.4054.60'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
