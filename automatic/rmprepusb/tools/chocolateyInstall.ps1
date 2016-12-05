$packageName = '{{PackageName}}'
$installerType = 'EXE'
$url = '{{DownloadUrl}}'
$silentArgs = '/S'
$chocTempDir = Join-Path $env:TEMP 'chocolatey'
$tempDir = Join-Path $chocTempDir $packageName
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

try {

	Install-ChocolateyZipPackage $packageName $url $tempDir
	
	$installer = Join-Path $tempDir 'Install_RMPrepUSB_Full.exe'
	
	Install-ChocolateyPackage $packageName $installerType $silentArgs $installer -validExitCodes $validExitCodes
  
	Write-ChocolateySuccess $packageName
	
} catch {
	Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw 
}