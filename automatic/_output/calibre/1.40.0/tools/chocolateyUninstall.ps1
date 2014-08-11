$packageName = "calibre"
$packageWildCard = $packageName + "*";

try {
	$app = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like $packageWildCard  -and ($_.Version -eq "1.40.0") }
	$result = $app.Uninstall();
	
	Write-ChocolateySuccess $packageName
}
catch {
	Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
	throw
}