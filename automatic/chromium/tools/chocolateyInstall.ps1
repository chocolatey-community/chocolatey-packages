$ErrorActionPreference = 'Stop'

$version = '57.0.2939.0'

$chromium_string = "\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Chromium"
$hive = "hkcu"
$Chromium = $hive + ":" + $chromium_string

if (Test-Path $Chromium) {
  $silentArgs = '--do-not-launch-chrome'
} else {
  $silentArgs = '--system-level --do-not-launch-chrome'
}

$packageArgs = @{
  packageName   = 'chromium'
  fileType      = 'exe'
  url           = 'https://storage.googleapis.com/chromium-browser-snapshots/Win/435552/mini_installer.exe'
  url64bit      = 'https://storage.googleapis.com/chromium-browser-snapshots/Win_x64/435548/mini_installer.exe'
  silentArgs    = $silentArgs
  validExitCodes= @(0)
  softwareName  = 'Chromium'
  checksum      = '0e76cb5d89aaf9d76b0ba5dcc912e92f'
  checksumType  = 'md5'
  checksum64    = 'da70d9e3c9f0e525ea464cfb48d96e53'
  checksumType64= 'md5'
}

Install-ChocolateyPackage @packageArgs
