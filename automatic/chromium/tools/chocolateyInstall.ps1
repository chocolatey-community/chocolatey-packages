$ErrorActionPreference = 'Stop'

$version = '56.0.2890.0'

$chromium_string = "\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Chromium"
$hive = "hkcu"
$Chromium = $hive + ":" + $chromium_string

if (Test-Path $Chromium) {
  $silentArgs = ''
} else {
  $silentArgs = '--system-level --do-not-launch-chrome'
}

$packageArgs = @{
  packageName   = 'chromium'
  fileType      = 'exe'
  url           = 'https://storage.googleapis.com/chromium-browser-snapshots/Win/425259/mini_installer.exe'
  url64bit      = 'https://storage.googleapis.com/chromium-browser-snapshots/Win_x64/425256/mini_installer.exe'
  silentArgs    = $silentArgs
  validExitCodes= @(0)
  softwareName  = 'Chromium'
  checksum      = '0e9dfb1ac26e79092c50d373153265e5'
  checksumType  = 'md5'
  checksum64    = 'eb7aa4f1eb6fbece11a0cb072cadd84f'
  checksumType64= 'md5'
}

Install-ChocolateyPackage @packageArgs
