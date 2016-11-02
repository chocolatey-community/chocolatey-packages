$ErrorActionPreference = 'Stop'

$version = '56.0.2908.0'

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
  url           = 'https://storage.googleapis.com/chromium-browser-snapshots/Win/429198/mini_installer.exe'
  url64bit      = 'https://storage.googleapis.com/chromium-browser-snapshots/Win_x64/429196/mini_installer.exe'
  silentArgs    = $silentArgs
  validExitCodes= @(0)
  softwareName  = 'Chromium'
  checksum      = 'ed05349851509bf324c74ec3faa36634'
  checksumType  = 'md5'
  checksum64    = '3fd649c9d296c2117988fa1087a1430e'
  checksumType64= 'md5'
}

Install-ChocolateyPackage @packageArgs
