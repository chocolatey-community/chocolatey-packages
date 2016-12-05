$packageName = '{{PackageName}}'
$installerType = 'EXE'
$silentArgs = '/S'
$hklm = "hklm:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Unity"
$file = (Get-ItemProperty -Path $hklm).UninstallString;

try {
	
	if (Get-ProcessorBits 64) {
  		$hklm = "hklm:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Unity"
	}
		
	Uninstall-ChocolateyPackage -PackageName $packageName -FileType $installerType -silentArgs $silentArgs -File $file
  
	Write-ChocolateySuccess $packageName
	
} catch {
	Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw
}