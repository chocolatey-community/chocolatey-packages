$packageName = "{{PackageName}}"
$productName = "SmartFTP Client";

try {
	$app = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -eq $productName -and ($_.Version -eq "{{PackageVersion}}") }
	$result = $app.Uninstall();

	Write-ChocolateySuccess $packageName
}
catch {
	Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
	throw
}