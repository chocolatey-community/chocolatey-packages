$packageName = '{{PackageName}}'
$installerType = 'EXE'
$silentArgs = '/S'
$unpath = "${Env:ProgramFiles(x86)}\Unity\WebPlayer\Uninstall.exe"
$unpath_64 = "$Env:ProgramFiles\Unity\WebPlayer64\Uninstall.exe"
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

try {

  	if (Test-Path $unpath_64){
		$unpath = $unpath_64
	}
  
	Uninstall-ChocolateyPackage $packageName $installerType $silentArgs $unpath -validExitCodes $validExitCodes
  
	Write-ChocolateySuccess $packageName
	
} catch {
	Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw 
}
