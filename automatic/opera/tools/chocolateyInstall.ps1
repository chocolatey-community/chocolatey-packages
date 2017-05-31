$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

if (Is32BitInstalled) { $env:ChocolateyForceX86 = $true }

$version     = '45.0.2552.888'
$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/45.0.2552.888/win/Opera_45.0.2552.888_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/45.0.2552.888/win/Opera_45.0.2552.888_Setup_x64.exe'
  checksum       = 'c1ec10f26a5341083282bb17d01179fc4b9bf98afe307f67012dfd4304a9a9de'
  checksum64     = '3677e1b1fe84b34104044146972df652d7fd74c95c47542d4e1aa4c7fac11abe'
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
