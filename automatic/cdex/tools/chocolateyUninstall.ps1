$packageName = '{{PackageName}}'
$installerType = 'EXE'
$silentArgs = '/S'
$desktop = $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::DesktopDirectory))
$shortcut_to_remove = "CDex.exe.lnk"
$processor = Get-WmiObject Win32_Processor
$is64bit = $processor.AddressWidth -eq 64
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

try {

	if ($is64bit) {
		$unpath = "${Env:ProgramFiles(x86)}\CDex\uninstall.exe"
	} else {
		$unpath = "$Env:ProgramFiles\CDex\uninstall.exe"
	}
  
	Uninstall-ChocolateyPackage $packageName $installerType $silentArgs $unpath -validExitCodes $validExitCodes
	
	Remove-Item "$desktop\$shortcut_to_remove"
    
	Write-ChocolateySuccess $packageName
	
} catch {
	Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw 
}