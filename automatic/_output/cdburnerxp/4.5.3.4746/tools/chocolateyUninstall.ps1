$packageName = "cdburnerxp"
$packageWildCard = $packageName + "*";

try {
	$app = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like $packageWildCard  -and ($_.Version -eq "4.5.3.4746") }
	$result = $app.Uninstall();

	Write-ChocolateySuccess $packageName
}
catch {
	Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
	throw
}