$ErrorActionPreference = 'Stop'

$version = '63.0.3217.0'

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
  url           = 'https://storage.googleapis.com/chromium-browser-snapshots/Win/502148/mini_installer.exe'
  url64bit      = 'https://storage.googleapis.com/chromium-browser-snapshots/Win_x64/502154/mini_installer.exe'
  silentArgs    = $silentArgs
  validExitCodes= @(0)
  softwareName  = 'Chromium'
  checksum      = '769c9b6cb75f2826ca29556cc00fd160'
  checksumType  = 'md5'
  checksum64    = 'c1b93fc79cc0d0fafdbe7cbd5c2d12cf'
  checksumType64= 'md5'
}

Install-ChocolateyPackage @packageArgs
