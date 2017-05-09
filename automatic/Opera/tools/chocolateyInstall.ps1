$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

if (Is32BitInstalled) { $env:ChocolateyForceX86 = $true }

$version     = '45.0.2552.635'
$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/45.0.2552.635/win/Opera_45.0.2552.635_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/45.0.2552.635/win/Opera_45.0.2552.635_Setup_x64.exe'
  checksum       = '41d6e4a0278861379685988d71521d82d0c3554916a80dd54a26e3010bd92cc8'
  checksum64     = 'a72c2b10e016132b755c26b662196c8b781e90bbdd4683d31c7d23e20330789a'
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
