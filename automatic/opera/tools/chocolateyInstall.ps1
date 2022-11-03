$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/92.0.4561.43/win/Opera_92.0.4561.43_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/92.0.4561.43/win/Opera_92.0.4561.43_Setup_x64.exe'
  checksum       = 'ab22ba6ceef6396f3b1e3e391cc236734b24b856ab137d24c1d330f7fa411395'
  checksum64     = '9708646ce01c4120417267029ba5152a7bf8345ff8c265ea3ed76c7a1a470bc8'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '92.0.4561.43'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
