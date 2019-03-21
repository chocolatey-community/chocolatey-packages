$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/58.0.3135.117/win/Opera_58.0.3135.117_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/58.0.3135.117/win/Opera_58.0.3135.117_Setup_x64.exe'
  checksum       = '677df46e119e74bf5c1642d50ed30bb94b75fd3909967c1d19ee89153209294e'
  checksum64     = '02a7e68071118f12135c09f4a6e94f240a930fa2caf00978e43dbad0662668cd'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '58.0.3135.117'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
