$packageName = '{{PackageName}}'
$fileType = 'exe'
$version = '{{PackageVersion}}'
$systemIs64bit = Get-ProcessorBits
$url = @{$true = "{{DownloadUrlx64}}"; $false = "{{DownloadUrl}}"}[$systemIs64bit -eq 64]
$checksum = @{$true = "{{Checksumx64}}"; $false = "{{Checksum}}"}[$systemIs64bit -eq 64]
$checksumType = 'md5'

	$chromium_string = "\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Chromium"
	$hive = "hkcu"
	$Chromium = $hive + ":\" + $chromium_string
  
  if (Test-Path $Chromium) {
    $silentArgs = ''
  } else {
    $silentArgs = '--system-level --do-not-launch-chrome'
  }
  
    Install-ChocolateyPackage $packageName $fileType $silentArgs $url $validExitCodes $checksum $checksumType
