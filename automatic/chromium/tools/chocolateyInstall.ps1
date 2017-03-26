$ErrorActionPreference = 'Stop'

$version = '59.0.3053.0'

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
  url           = 'https://storage.googleapis.com/chromium-browser-snapshots/Win/459659/mini_installer.exe'
  url64bit      = 'https://storage.googleapis.com/chromium-browser-snapshots/Win_x64/459659/mini_installer.exe'
  silentArgs    = $silentArgs
  validExitCodes= @(0)
  softwareName  = 'Chromium'
  checksum      = 'df2a64e75877dd642d84fbb7981014fc'
  checksumType  = 'md5'
  checksum64    = 'df398e100201de89a688c3cec6968802'
  checksumType64= 'md5'
}

Install-ChocolateyPackage @packageArgs
