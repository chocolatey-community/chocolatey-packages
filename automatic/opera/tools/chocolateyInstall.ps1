$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/93.0.4585.70/win/Opera_93.0.4585.70_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/93.0.4585.70/win/Opera_93.0.4585.70_Setup_x64.exe'
  checksum       = 'c456fe4b9973cb60c6920d4427cf2c11f598530754a26d981e48446bbdce50f6'
  checksum64     = '7d3796425c75d52f10eb8c07ea913cbcefa6cd979729b9df37807aeea460ea5d'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '93.0.4585.70'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
