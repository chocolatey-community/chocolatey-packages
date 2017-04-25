$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

if (Is32BitInstalled) { $env:ChocolateyForceX86 = $true }

$version     = '44.0.2510.1218'
$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/44.0.2510.1218/win/Opera_44.0.2510.1218_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/44.0.2510.1218/win/Opera_44.0.2510.1218_Setup_x64.exe'
  checksum       = 'd854aff85480989e3a903444ab4e6598fd20bbea37e589279b0cf9a93057f819'
  checksum64     = 'dae0985cfb3931e81e488056db169c5b520a28e8190e559b467d6cdf553afb57'
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
