$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/98.0.4759.15/win/Opera_98.0.4759.15_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/98.0.4759.15/win/Opera_98.0.4759.15_Setup_x64.exe'
  checksum       = '8fef9222d79b326d0999a2510f0887828427f78a436a619f2f40ce861c052fd2'
  checksum64     = 'c3a2fb8dd72c6ffae84cf20d8f27f25dcdd33ed2b594a594b0fafa3f5449e270'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '98.0.4759.15'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
