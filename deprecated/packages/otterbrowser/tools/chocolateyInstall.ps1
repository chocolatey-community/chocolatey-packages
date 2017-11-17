$packageName = 'otterbrowser'
$installerType = 'EXE'
$url = 'http://skylink.dl.sourceforge.net/project/otter-browser/otter-browser-beta3/otter-browser-win32-0.9.03-beta3-setup.exe'
$url64 = 'http://freefr.dl.sourceforge.net/project/otter-browser/otter-browser-beta3/otter-browser-win64-0.9.03-beta3-setup.exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

try {

	Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64 -validExitCodes $validExitCodes
	
	Write-ChocolateySuccess $packageName
	
} catch {
	Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw 
}