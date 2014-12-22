$packageName = '{{PackageName}}'
$installerType = 'EXE'
$silentArgs = '/S'
$validExitCodes = @(0)

try {
  $osBitness = Get-ProcessorBits
  
  if ($osBitness -eq 64) {
    $file = (Get-ItemProperty -Path "hklm:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Fiddler2").UninstallString
  } else {
    $file = (Get-ItemProperty -Path "hklm:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Fiddler2").UninstallString
  } 
	
	Uninstall-ChocolateyPackage -PackageName $packageName -FileType $installerType -SilentArgs $silentArgs -validExitCodes $validExitCodes -File $file
  
	Write-ChocolateySuccess $package
} catch {
	Write-ChocolateyFailure $package "$($_.Exception.Message)" 
	throw
}