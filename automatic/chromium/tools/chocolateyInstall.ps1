$packageName = '{{PackageName}}'
$fileType = 'exe'
$version = '{{PackageVersion}}'
$url = '{{DownloadUrl}}'
$url64bit = '{{DownloadUrlx64}}'


function GetLevel() {

	$chromium_string = "\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Chromium"
	$hive = "hkcu"
	$Chromium = $hive + ":\" + $chromium_string
  
  if (Test-Path $Chromium) {
    $level = ''
  } else {
    $level = '--system-level --do-not-launch-chrome'
  }
  
  return $level
}

function Get-32bitOnlyInstalled {
  $systemIs64bit = Get-ProcessorBits 64
  
  if (-Not $systemIs64bit) {
    return $false
}

}
  $silentArgs = GetLevel
  
  if ((Get-32bitOnlyInstalled) -or (Get-ProcessorBits 32)) {
    Install-ChocolateyPackage $packageName $fileType $silentArgs $url
  } else {
    Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64
}
