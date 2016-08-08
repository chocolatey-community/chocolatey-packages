  $packageArgs = @{
  packageName   = '{{PackageName}}'
  fileType      = 'exe'
  url           = '{{DownloadUrl}}'
  url64bit      = '{{DownloadUrlx64}}'
  silentArgs    = $silentArgs
  validExitCodes= @(0)
  softwareName  = 'Chromium'
  checksum      = '{{Checksum}}'
  checksumType  = 'md5'
  checksum64    = '{{Checksumx64}}'
  checksumType64= 'md5'
}
$version = '{{PackageVersion}}'

	$chromium_string = "\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Chromium"
	$hive = "hkcu"
	$Chromium = $hive + ":\" + $chromium_string
  
  if (Test-Path $Chromium) {
    $silentArgs = ''
  } else {
    $silentArgs = '--system-level'
  }

    Install-ChocolateyPackage @packageArgs
