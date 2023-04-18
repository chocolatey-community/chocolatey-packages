$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/97.0.4719.83/win/Opera_97.0.4719.83_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/97.0.4719.83/win/Opera_97.0.4719.83_Setup_x64.exe'
  checksum       = 'b4ce25541abc6e1452e1d72f1d6521986433fbb4044570e3eb42a294b5ae5de4'
  checksum64     = 'db5dcf717307445702e11192b6acf540382aa46bf8fc18095e2739415b851df1'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '97.0.4719.83'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
