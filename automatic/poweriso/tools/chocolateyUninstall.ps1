$packageName = '{{PackageName}}'
$installerType = 'EXE'
$silentArgs = '/S'
$validExitCodes = @(0)

try {
	$regKey = "hklm:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\PowerISO";
  
  if ($osBitness -eq 64) {
    $regKey = "hklm:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\PowerISO";
  }
  
	$file = (Get-ItemProperty -Path $regKey).UninstallString
	Uninstall-ChocolateyPackage -PackageName $packageName -FileType $installerType -SilentArgs $silentArgs -validExitCodes $validExitCodes -File $file
  
	Write-ChocolateySuccess $package
} catch {
	Write-ChocolateyFailure $package "$($_.Exception.Message)" 
	throw
}