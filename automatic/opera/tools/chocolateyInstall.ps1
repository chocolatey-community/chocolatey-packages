$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/54.0.2952.51/win/Opera_54.0.2952.51_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/54.0.2952.51/win/Opera_54.0.2952.51_Setup_x64.exe'
  checksum       = 'a19b60bb236f52bcca7759f86b095262096c655c2879044dd5c4767da85080ec'
  checksum64     = 'e2bed28238bdc783e09ce2c8cf24c7dd36ea59f8e39f9185ba7fdbaca81b3656'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '54.0.2952.51'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
