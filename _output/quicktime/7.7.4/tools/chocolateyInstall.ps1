$packageName = 'quicktime'
$url = 'http://appldnld.apple.com/QuickTime/041-9648.20130522.Rftg5/QuickTimeInstaller.exe'
$fileType = 'msi'
$silentArgs = '/quiet'
$filePath = "$env:TEMP\chocolatey\$packageName"
$fileFullPath = "$filePath\$packageName`Install.exe"

try {
	if (-not (Test-Path $filePath)) {
		New-Item -ItemType directory -Path $filePath
	}

	Get-ChocolateyWebFile $packageName $fileFullPath $url

	Start-Process "7za" -ArgumentList "x -o`"$filePath`" -y `"$fileFullPath`"" -Wait

	$packageName = 'appleapplicationsupport'
	$file = "$filePath\AppleApplicationSupport.msi"
	Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file

	$packageName = 'quicktime'
	$file = "$filePath\QuickTime.msi"
	Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file
	
    Write-ChocolateySuccess "$packageName"
} catch {
    Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
    throw
}