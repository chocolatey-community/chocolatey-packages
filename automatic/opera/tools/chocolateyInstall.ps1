$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/80.0.4170.72/win/Opera_80.0.4170.72_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/80.0.4170.72/win/Opera_80.0.4170.72_Setup_x64.exe'
  checksum       = '27f711fec567283bcb311f9ce1ef75ab3b1afa23c5c44b99eebc3b7fe1bd3504'
  checksum64     = '318c23e5afbb1d466f7affde44488d8af4d830593c05f6f794d51a1f4a14fc84'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '80.0.4170.72'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
