$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/98.0.4759.6/win/Opera_98.0.4759.6_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/98.0.4759.6/win/Opera_98.0.4759.6_Setup_x64.exe'
  checksum       = 'a20182014248e2998c1d1c664ff9156df7ed812bf1061ba6fb1e005fa2207b28'
  checksum64     = '93ddf3ae08b009aa2f47cdcd62ab17ae95e217e7c01a85e360a8700eac063d0f'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '98.0.4759.6'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
