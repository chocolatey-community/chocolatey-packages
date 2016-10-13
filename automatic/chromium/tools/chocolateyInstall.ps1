
  $version = '{{PackageVersion}}'

	$chromium_string = "\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Chromium"
	$hive = "hkcu"
	$Chromium = $hive + ":" + $chromium_string
  
  if (Test-Path $Chromium) {
    $silentArgs = ''
  } else {
    $silentArgs = '--system-level --do-not-launch-chrome'
  }
  
    $packageArgs = @{
  packageName   = 'Chromium'
  fileType      = 'exe'
  url           = 'https://storage.googleapis.com/chromium-browser-snapshots/Win/425094/mini_installer.exe'
  url64bit      = 'https://storage.googleapis.com/chromium-browser-snapshots/Win_x64/425083/mini_installer.exe'
  silentArgs    = $silentArgs
  validExitCodes= @(0)
  softwareName  = 'Chromium'
  checksum      = '97da1f6f835b4b6ca7156c723e897083'
  checksumType  = 'md5'
  checksum64    = '0ffc77b8638e7f5c0d5bb8c6cf02aeff'
  checksumType64= 'md5'
}

    Install-ChocolateyPackage @packageArgs
