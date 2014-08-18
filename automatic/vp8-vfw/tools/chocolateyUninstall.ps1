try {

	$packageName = '{{PackageName}}'
	$fileType = 'exe'
	$silentArgs = '/VERYSILENT'
	$validExitCodes = @(0)
	$file = "$env:windir\unins000.exe"

	if (Test-Path "$file") {
		Uninstall-ChocolateyPackage $packageName $fileType $silentArgs $file -validExitCodes $validExitCodes
	}

	Write-ChocolateySuccess $packageName
} catch {
	Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw
}
