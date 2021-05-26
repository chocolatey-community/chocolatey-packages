$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/76.0.4017.154/win/Opera_76.0.4017.154_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/76.0.4017.154/win/Opera_76.0.4017.154_Setup_x64.exe'
  checksum       = 'da26b2eff75767a6c3a2a9a046ea1cd4588c7d4dddab9f5abf4f3a7c4ad39e56'
  checksum64     = '6155c425e22f260e018554982f075f36d3096413a777f5329378c08849f98d75'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '76.0.4017.154'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
