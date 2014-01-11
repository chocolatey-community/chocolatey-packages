$packageName = '{{PackageName}}'
$installerType = 'EXE'
$silentArgs = '/S'
$validExitCodes = @(0)

try {
	# HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\PowerISO
	$file = (Get-ItemProperty -Path "hklm:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\PowerISO").UninstallString
	Uninstall-ChocolateyPackage -PackageName $packageName -FileType $installerType -SilentArgs $silentArgs -validExitCodes $validExitCodes -File $file
  
	Write-ChocolateySuccess $package
} catch {
	Write-ChocolateyFailure $package "$($_.Exception.Message)" 
	throw
}