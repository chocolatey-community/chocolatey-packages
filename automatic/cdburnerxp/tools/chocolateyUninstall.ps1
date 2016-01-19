$packageName = "{{PackageName}}"
$packageWildCard = $packageName + "*";

$app = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like $packageWildCard  -and ($_.Version -eq "{{PackageVersion}}") }
$result = $app.Uninstall();
