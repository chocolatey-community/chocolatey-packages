$packageName = '{{PackageName}}'
$version = '{{PackageVersion}}'

$installerType = 'msi'
$url = '{{DownloadUrl}}'
$url64 = '{{DownloadUrlx64}}'

$silentArgs = '/passive'
$validExitCodes = @(0)

try {

	$alreadyInstalled = Get-WmiObject -Class Win32_Product | Where-Object {($_.Name -match 'Jitsi') -and ($_.Version -match $version)}

	if ($alreadyInstalled) {
		Write-Output "Jitsi $softwareVersion is already installed on the computer. Skipping download and installation."
	} else {
		Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64 -validExitCodes $validExitCodes
	}

} catch {
	Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw
}
