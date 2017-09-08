$ErrorActionPreference = 'Stop'

$version = '63.0.3211.0'

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
  url           = 'https://storage.googleapis.com/chromium-browser-snapshots/Win/500556/mini_installer.exe'
  url64bit      = 'https://storage.googleapis.com/chromium-browser-snapshots/Win_x64/500555/mini_installer.exe'
  silentArgs    = $silentArgs
  validExitCodes= @(0)
  softwareName  = 'Chromium'
  checksum      = 'ef7f300ba9f27a4e71b180f4da7baf87'
  checksumType  = 'md5'
  checksum64    = '89ec0cb8bcf4872e722c7bf0b16b8b0c'
  checksumType64= 'md5'
}

Install-ChocolateyPackage @packageArgs
