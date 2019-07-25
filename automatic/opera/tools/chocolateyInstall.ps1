$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }
$parameters += if ($pp.InstallAllUsers)     { " /allusers=1"; Write-Host "Install Opera for all users, and not only the current one." }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/62.0.3331.99/win/Opera_62.0.3331.99_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/62.0.3331.99/win/Opera_62.0.3331.99_Setup_x64.exe'
  checksum       = 'd54083619d70594791f814aa615ba81563e38f9a9c52aacddb4aa803f2a2cd2f'
  checksum64     = '301ea4ece36b68631c90b26c8c3e3f54e4ec23e826febd594398cca508e75819'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0' + $parameters
  validExitCodes = @(0)
}

$version = '62.0.3331.99'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
