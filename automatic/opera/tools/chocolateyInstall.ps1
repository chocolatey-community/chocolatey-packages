$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/83.0.4254.19/win/Opera_83.0.4254.19_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/83.0.4254.19/win/Opera_83.0.4254.19_Setup_x64.exe'
  checksum       = 'e94d2e29d2a3c663e904abbcde0b8baa9eef92e6fb41b235bb95a3846770a5a1'
  checksum64     = '3921451072fd379797266cd1045b2ad73238ccbda3ad2a973f6b95778e80f2fe'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '83.0.4254.19'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
