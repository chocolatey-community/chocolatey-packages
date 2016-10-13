$packageName = '{{PackageName}}'
$installerType = 'exe'
$bitness = Get-ProcessorBits
$bitty = @{$true = "\WOW6432Node"; $false = ""}[$bitness -eq 64]
	
	$chromium_string = "\SOFTWARE" + $bitty +"\Microsoft\Windows\CurrentVersion\Uninstall\Chromium"
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
  
Uninstall-ChocolateyPackage -PackageName $packageName -FileType $installerType -SilentArgs $silentArgs -validExitCodes $validExitCodes -File $file
