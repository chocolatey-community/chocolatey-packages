$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/53.0.2907.37/win/Opera_53.0.2907.37_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/53.0.2907.37/win/Opera_53.0.2907.37_Setup_x64.exe'
  checksum       = 'a8946f3a813a0c0b568837293eade264b7017f196469fd807736b458a4728c67'
  checksum64     = '814587a9de3baa1a9c3b6e1ba43fa598d9acc46094a42e49af955893a3c09313'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0'
  validExitCodes = @(0)
}

$version = '53.0.2907.37'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
