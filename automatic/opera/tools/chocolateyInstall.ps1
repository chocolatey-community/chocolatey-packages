$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/57.0.3098.76/win/Opera_57.0.3098.76_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/57.0.3098.76/win/Opera_57.0.3098.76_Setup_x64.exe'
  checksum       = '0f511066827803f2867dc3012da65c322e0257639fe5b28e9e6edcd579c7966e'
  checksum64     = 'c223c88824f8eae38a248f541d5e5b419a5254b36e5322ade1511ffdd0db39fe'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '57.0.3098.76'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
