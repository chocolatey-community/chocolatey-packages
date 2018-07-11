$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/54.0.2952.54/win/Opera_54.0.2952.54_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/54.0.2952.54/win/Opera_54.0.2952.54_Setup_x64.exe'
  checksum       = '39311f0845f1409fe90cdefcd1839959b6017b7c75ff101ea818eb524af3e3bf'
  checksum64     = '1abe367c848af2750f1517ab3a110fc86a0d0097552ffac707d75fafeba4a537'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '54.0.2952.54'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
