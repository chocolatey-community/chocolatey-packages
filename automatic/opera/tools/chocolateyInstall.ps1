$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/99.0.4788.77/win/Opera_99.0.4788.77_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/99.0.4788.77/win/Opera_99.0.4788.77_Setup_x64.exe'
  checksum       = '80b4365c22ace7ed508db2dbd876df649afb66f2a66148aeb9782cd56345164f'
  checksum64     = 'a0e539df5702bc865e915748ea6916e11ecfc1a4cfe044d19cbceb7051eba130'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '99.0.4788.77'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
