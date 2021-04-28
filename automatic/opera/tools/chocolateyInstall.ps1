$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/76.0.4017.94/win/Opera_76.0.4017.94_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/76.0.4017.94/win/Opera_76.0.4017.94_Setup_x64.exe'
  checksum       = 'da87976d1fde391b09e00a247104ea0fe7ab391bea101bf197fe47f40f361c63'
  checksum64     = '7ce3aca1a9e8a8e540c36fecfbd4543a16759e15bbe2e5b4bf3d5ad17c5be62e'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '76.0.4017.94'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
