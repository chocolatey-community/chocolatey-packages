$ErrorActionPreference = 'Stop'

$version = '62.0.3169.0'

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
  url           = 'https://storage.googleapis.com/chromium-browser-snapshots/Win/489853/mini_installer.exe'
  url64bit      = 'https://storage.googleapis.com/chromium-browser-snapshots/Win_x64/489856/mini_installer.exe'
  silentArgs    = $silentArgs
  validExitCodes= @(0)
  softwareName  = 'Chromium'
  checksum      = '17de11566369deb6e1c139e4c396f5a3'
  checksumType  = 'md5'
  checksum64    = 'c0ed4418ae33ea0cbba3892b83dbf984'
  checksumType64= 'md5'
}

Install-ChocolateyPackage @packageArgs
