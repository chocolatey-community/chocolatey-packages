$packageName = '{{PackageName}}'
$installerType = 'EXE'
#$silentArgs = '/S'
$processor = Get-WmiObject Win32_Processor
$is64bit = $processor.AddressWidth -eq 64
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

try {

	if ($is64bit) {
		$unpath = "${Env:ProgramFiles(x86)}\Tweaking.com\Windows Repair (All in One)\uninstall.exe"
		$silentArgs1 = "/U:${Env:ProgramFiles(x86)}\Tweaking.com\Windows Repair (All in One)\Uninstall\uninstall.xml"
	} else {
		$unpath = "$Env:ProgramFiles\Tweaking.com\Windows Repair (All in One)\uninstall.exe"
		$silentArgs1 = "/U:$Env:ProgramFiles\Tweaking.com\Windows Repair (All in One)\Uninstall\uninstall.xml"
	}
	
	#Command necessary to uninstall silently correctly. One form.
	
	& $unpath $silentArgs1 /S
	
	#Uninstall-ChocolateyPackage $packageName $installerType $silentArgs $unpath -validExitCodes $validExitCodes
    
	Write-ChocolateySuccess $packageName
	
} catch {
	Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw 
}