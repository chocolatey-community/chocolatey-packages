$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/74.0.3911.144/win/Opera_74.0.3911.144_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/74.0.3911.144/win/Opera_74.0.3911.144_Setup_x64.exe'
  checksum       = '4e19eacab520a6c69c12b11b6841672336d749ff06ef839a345d80a414f7fc5b'
  checksum64     = '0f85ce6fabbf326cbb1cdff70dd6af6f496202f4025537c89c84d1c83768e363'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '74.0.3911.144'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
