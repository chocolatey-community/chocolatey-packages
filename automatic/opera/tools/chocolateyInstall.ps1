$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/86.0.4363.32/win/Opera_86.0.4363.32_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/86.0.4363.32/win/Opera_86.0.4363.32_Setup_x64.exe'
  checksum       = 'dff8326235855e4ec7a3ccc5dbdad40c544b563afa8c53ab0f9f02587cc6b090'
  checksum64     = '68ae8e8db1b43ec2a526cee5132771b5c192a3f915b45468d99df731d8198acc'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '86.0.4363.32'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
