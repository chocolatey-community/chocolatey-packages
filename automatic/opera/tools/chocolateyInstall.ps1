$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/97.0.4719.28/win/Opera_97.0.4719.28_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/97.0.4719.28/win/Opera_97.0.4719.28_Setup_x64.exe'
  checksum       = '71ed29f21528b0a829354cb12c9579c86098793f1823101526e59ab68731b172'
  checksum64     = 'b9a22e7103a5c75ca612c5386d29d9cf8c078521ea7f78a14687e9bee35e8fea'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '97.0.4719.28'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
