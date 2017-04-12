$ErrorActionPreference = 'Stop'

$version = '59.0.3070.0'

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
  url           = 'https://storage.googleapis.com/chromium-browser-snapshots/Win/463982/mini_installer.exe'
  url64bit      = 'https://storage.googleapis.com/chromium-browser-snapshots/Win_x64/463982/mini_installer.exe'
  silentArgs    = $silentArgs
  validExitCodes= @(0)
  softwareName  = 'Chromium'
  checksum      = 'e494e37d84fb4f8dbbc1c8a9a1a2a9af'
  checksumType  = 'md5'
  checksum64    = 'cb6dcf7b018e3e7e512df8fabe6fce90'
  checksumType64= 'md5'
}

Install-ChocolateyPackage @packageArgs
