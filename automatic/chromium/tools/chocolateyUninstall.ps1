$packageName = 'Chromium'
$installerType = 'exe'
$bitness = @{$true = "\WOW6432Node"; $false = ""}[ (Get-ProcessorBits) -eq 64]
	
	$chromium_string = "\SOFTWARE" + $bitness +"\Microsoft\Windows\CurrentVersion\Uninstall\Chromium"
	$hive = "hkcu"
	$Chromium = $hive + ":" + $chromium_string

	if ( (Test-Path $Chromium) -eq $true ) {
	  $hk_level = "hkcu"
	} else {
	  $hk_level = "hklm"
	}

  if ( (Test-Path ( $hk_level + ":" +$chromium_string )) -eq $true ) {
    $chromium_key = ( $hk_level + ":" + $chromium_string )
  } else  {
    $chromium_key = ( "hkcu:" + "\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Chromium" )
  }
	$file = (Get-ItemProperty -Path ( $chromium_key ) ).UninstallString
  return $file
  
Uninstall-ChocolateyPackage -PackageName $packageName -FileType $installerType -SilentArgs $silentArgs -validExitCodes $validExitCodes -File $file
