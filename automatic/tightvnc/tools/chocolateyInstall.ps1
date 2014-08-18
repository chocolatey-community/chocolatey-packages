$packageName = '{{PackageName}}'
$fileType = 'msi'
$silentArgs = '/quiet /norestart'
$url = '{{DownloadUrl}}'
$url64bit = '{{DownloadUrlx64}}'

try {

	Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit


	# This reads the service start mode of 'TightVNC Server' and adapts it to the current value,
	# otherwise it would always be set to 'Auto' on new installations, even if it was 'Manual'
	# or 'disabled' before
	$serviceStartMode = (Get-wmiobject win32_service -Filter "Name = 'tvnserver'").StartMode

	if ($serviceStartMode -ne $null) {
		if ($serviceStartMode -ne 'Auto') {
			Start-ChocolateyProcessAsAdmin "Set-Service -Name tvnserver -StartupType $serviceStartMode"
		}
	}

} catch {

	Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw
}
