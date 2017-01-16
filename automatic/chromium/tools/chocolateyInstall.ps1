$ErrorActionPreference = 'Stop'

$version = '57.0.2984.0'

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
  url           = 'https://storage.googleapis.com/chromium-browser-snapshots/Win/443847/mini_installer.exe'
  url64bit      = 'https://storage.googleapis.com/chromium-browser-snapshots/Win_x64/443847/mini_installer.exe'
  silentArgs    = $silentArgs
  validExitCodes= @(0)
  softwareName  = 'Chromium'
  checksum      = '7cc32f7220a1bf89ab5e5f1c33a06e03'
  checksumType  = 'md5'
  checksum64    = 'cfcf8838913dbf175beb4ff065af182c'
  checksumType64= 'md5'
}

Install-ChocolateyPackage @packageArgs
