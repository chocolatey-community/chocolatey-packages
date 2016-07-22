$packageName = '{{PackageName}}'
$fileType = 'exe'
$version = '{{PackageVersion}}'
$url = '{{DownloadUrl}}'
$url64bit = '{{DownloadUrlx64}}'

	$chromium_string = "\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Chromium"
	$hive = "hkcu"
	$Chromium = $hive + ":\" + $chromium_string
  
  if (Test-Path $Chromium) {
    $silentArgs = ''
  } else {
    $silentArgs = '--system-level --do-not-launch-chrome'
  }
  
  $systemIs64bit = Get-ProcessorBits
  
  if ($systemIs64bit -eq "32") {
    Install-ChocolateyPackage $packageName $fileType $silentArgs $url
  } else {
    Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64
  }
