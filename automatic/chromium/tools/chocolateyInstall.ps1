$ErrorActionPreference = 'Stop'

$version = '56.0.2921.0'

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
  url           = 'https://storage.googleapis.com/chromium-browser-snapshots/Win/432128/mini_installer.exe'
  url64bit      = 'https://storage.googleapis.com/chromium-browser-snapshots/Win_x64/432134/mini_installer.exe'
  silentArgs    = $silentArgs
  validExitCodes= @(0)
  softwareName  = 'Chromium'
  checksum      = '6c2b4fb7a17dc7a7b1468af933deb90f'
  checksumType  = 'md5'
  checksum64    = 'e4cafb6cba4c4627ef8d2c3dd7b3e681'
  checksumType64= 'md5'
}

Install-ChocolateyPackage @packageArgs
