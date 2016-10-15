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
  url           = 'https://storage.googleapis.com/chromium-browser-snapshots/Win/425547/mini_installer.exe'
  url64bit      = 'https://storage.googleapis.com/chromium-browser-snapshots/Win_x64/425547/mini_installer.exe'
  silentArgs    = $silentArgs
  validExitCodes= @(0)
  softwareName  = 'Chromium'
  checksum      = '6cd0cf2a3d52e93d6ba4458f17dbab1e'
  checksumType  = 'md5'
  checksum64    = '4eb6f4368aaedc55b3971520c914aa8f'
  checksumType64= 'md5'
}

Install-ChocolateyPackage @packageArgs
