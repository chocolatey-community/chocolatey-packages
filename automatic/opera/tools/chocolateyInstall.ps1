$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/94.0.4606.54/win/Opera_94.0.4606.54_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/94.0.4606.54/win/Opera_94.0.4606.54_Setup_x64.exe'
  checksum       = '3016155b9b955367a0a25bada5cbe108d398d93b483b6a8a4a666bd760118f09'
  checksum64     = 'e94b68a21761059b0f053321763c7987df5ab54a5b7ff87003bd413f0fba2ac6'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '94.0.4606.54'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
