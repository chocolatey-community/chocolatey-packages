$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/99.0.4788.9/win/Opera_99.0.4788.9_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/99.0.4788.9/win/Opera_99.0.4788.9_Setup_x64.exe'
  checksum       = 'a1980aa1077ab916cbddd93e2db4156b9dacf8b9f33d514247ae10ac01698528'
  checksum64     = '6e4b336edb2c074b76d4307bf9c15dea33fa14db6c3fd052412a8fc6d7f499e1'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '99.0.4788.9'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
