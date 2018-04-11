$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/52.0.2871.64/win/Opera_52.0.2871.64_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/52.0.2871.64/win/Opera_52.0.2871.64_Setup_x64.exe'
  checksum       = '0dfb50207543b867f99972aae31a8b5af749ab9280eaa889f739b4f41d87cb06'
  checksum64     = 'dfc798bd5122fa687ee7836a8bfd138f3fdccc2828b059b18716adacfd4f82f6'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0'
  validExitCodes = @(0)
}

$version = '52.0.2871.64'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
