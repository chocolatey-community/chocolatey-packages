$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoAutostart) { " /run-at-startup=0"; Write-Host "Autorun entry won't be added" }
$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/117.0.5408.163/win/Opera_117.0.5408.163_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/117.0.5408.163/win/Opera_117.0.5408.163_Setup_x64.exe'
  checksum       = '799b523653d45030172caf6052a9148e77f8b814cd8d885c372df48a408d6526'
  checksum64     = '5622e085880c3158558df29e93404a7b4b5a2eff9b3e2839da5674949485a62d'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '117.0.5408.163'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
