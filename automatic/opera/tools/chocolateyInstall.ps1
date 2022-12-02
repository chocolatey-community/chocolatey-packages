$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/93.0.4585.37/win/Opera_93.0.4585.37_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/93.0.4585.37/win/Opera_93.0.4585.37_Setup_x64.exe'
  checksum       = 'c08ad78787d845ad2b971150b5c445aaff11544f657fa060e2b0a1798e751a4c'
  checksum64     = 'd1fbae26615339ec2a1cdce89251e47f8f1fe3f2fc21b23a1eb8f8740a739886'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '93.0.4585.37'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
