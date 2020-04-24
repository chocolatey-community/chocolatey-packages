$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/68.0.3618.56/win/Opera_68.0.3618.56_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/68.0.3618.56/win/Opera_68.0.3618.56_Setup_x64.exe'
  checksum       = '259d57863dbc0387706e6bae47315b87a28ef71aafa7b77735f1f9ad664bdf8b'
  checksum64     = 'ddffa6656684a2afff26b08d581910c25dc50a0a5fa67482e9026ee1d527ee89'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '68.0.3618.56'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
