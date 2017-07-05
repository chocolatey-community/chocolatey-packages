$ErrorActionPreference = 'Stop'

$version = '61.0.3150.0'

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
  url           = 'https://storage.googleapis.com/chromium-browser-snapshots/Win/484185/mini_installer.exe'
  url64bit      = 'https://storage.googleapis.com/chromium-browser-snapshots/Win_x64/484185/mini_installer.exe'
  silentArgs    = $silentArgs
  validExitCodes= @(0)
  softwareName  = 'Chromium'
  checksum      = '10334d445b2bf9b0eade4be921ce2fdc'
  checksumType  = 'md5'
  checksum64    = 'b6ff92a1a4d7bbd6dd243b1cd37dee8b'
  checksumType64= 'md5'
}

Install-ChocolateyPackage @packageArgs
