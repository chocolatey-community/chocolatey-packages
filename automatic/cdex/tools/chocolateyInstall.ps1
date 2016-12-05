$packageName = '{{PackageName}}'
$installerType = 'EXE'
$url = '{{DownloadUrl}}'
$silentArgs = '/S'
$executable = "CDex\CDex.exe"
#$targetFilePath = " "
$processor = Get-WmiObject Win32_Processor
$is64bit = $processor.AddressWidth -eq 64
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

try {

	Install-ChocolateyPackage $packageName $installerType $silentArgs $url -validExitCodes $validExitCodes
	
	if ($is64bit) {
		$targetFilePath = "${Env:ProgramFiles(x86)}\$executable"
	} else {
		$targetFilePath = "$Env:ProgramFiles\$executable"
	}
 	
	Install-ChocolateyDesktopLink $targetFilePath
	
	Write-ChocolateySuccess $packageName
	
} catch {
	Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw 
}