$ErrorActionPreference = 'Stop'

$version = '57.0.2928.0'

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
  url           = 'https://storage.googleapis.com/chromium-browser-snapshots/Win/433817/mini_installer.exe'
  url64bit      = 'https://storage.googleapis.com/chromium-browser-snapshots/Win_x64/433828/mini_installer.exe'
  silentArgs    = $silentArgs
  validExitCodes= @(0)
  softwareName  = 'Chromium'
  checksum      = '2c255837bf16a55f14e3c5ba1a7b0a1b'
  checksumType  = 'md5'
  checksum64    = 'cff2c0f8ba56ad39ae92b1a5d11268d1'
  checksumType64= 'md5'
}

Install-ChocolateyPackage @packageArgs
