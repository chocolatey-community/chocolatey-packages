$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/63.0.3368.71/win/Opera_63.0.3368.71_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/63.0.3368.71/win/Opera_63.0.3368.71_Setup_x64.exe'
  checksum       = '3dad747bb1003daaa85ab5ec71e82e6fdd0ed483ba14999d168e37afeddfb5cf'
  checksum64     = '549c3d3e9c8feb48b4a8a9d47e45e3417e905ec085bc9c5f3c07106eb435e15f'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '63.0.3368.71'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
