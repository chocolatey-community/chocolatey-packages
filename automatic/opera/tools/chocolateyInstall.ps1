$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/76.0.4017.175/win/Opera_76.0.4017.175_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/76.0.4017.175/win/Opera_76.0.4017.175_Setup_x64.exe'
  checksum       = 'ad74515a48510af5efc10b38b46df45171dff3e72555bf3c6b41988f303c9eb9'
  checksum64     = '63086c902c943aa936f758c5dfe2d8e9b54367d4a8bbc4d5d8254b98bb36b64c'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '76.0.4017.175'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
