$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/49.0.2725.64/win/Opera_49.0.2725.64_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/49.0.2725.64/win/Opera_49.0.2725.64_Setup_x64.exe'
  checksum       = '92b40168229f4c3ee4249e5ef9edad8bf2efa4bcc3ee6b4e6c803b0d412fedd5'
  checksum64     = '1dd2abab679b5de2b0ca084219880c17d24e4a170d7680ab50d57ad808ac226a'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0'
  validExitCodes = @(0)
}

$version = '49.0.2725.64'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
