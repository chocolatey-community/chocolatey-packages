$packageName = '{{PackageName}}'
$installerType = 'EXE'
$validExitCodes = @(0)

	
	$chromium_string = "\SOFTWARE" + $bitness +"\Microsoft\Windows\CurrentVersion\Uninstall\Chromium"
	$hive = "hkcu"
	$Chromium = $hive + ":" + $chromium_string


	if (Test-Path $Chromium) {
	  $hk_level = "hkcu"
	} else {
	  $hk_level = "hklm"
	}

	$bitness = Get-ProcessorBits
	@{$true = "\WOW6432Node"; $false = ""}[$bitness -eq "64"]

	$file = (Get-ItemProperty -Path ( $hk_level + ":" +$chromium_string ) ).UninstallString
  

return $file

Uninstall-ChocolateyPackage -PackageName $packageName -FileType $installerType -SilentArgs $silentArgs -validExitCodes $validExitCodes -File $file
