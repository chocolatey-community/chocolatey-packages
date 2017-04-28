$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

if (Is32BitInstalled) { $env:ChocolateyForceX86 = $true }

$version     = '44.0.2510.1457'
$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/44.0.2510.1457/win/Opera_44.0.2510.1457_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/44.0.2510.1457/win/Opera_44.0.2510.1457_Setup_x64.exe'
  checksum       = '417834b5e9ffbf524101203dd361a106a2bc4e1ce063d58d8589fede6fbd4fcf'
  checksum64     = '3b9f1ebee9096634c6ca51a870474811c7e2cdcd1f9f1667a10c1b5ac99824c4'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0'
  validExitCodes = @(0)
}

if (IsVersionAlreadyInstalled $version) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
