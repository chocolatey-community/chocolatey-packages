$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/66.0.3515.115/win/Opera_66.0.3515.115_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/66.0.3515.115/win/Opera_66.0.3515.115_Setup_x64.exe'
  checksum       = '68abdf01da6665a6f0a28fafb6243cf18b1c91b7bf17107ec2e3ce8402a44d1b'
  checksum64     = '6752cbea1c65486dcf15a2f70c750440bb51f3680f8104a337a185da11f30fa5'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '66.0.3515.115'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
