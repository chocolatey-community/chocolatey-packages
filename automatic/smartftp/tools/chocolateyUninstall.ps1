$packageName = "{{PackageName}}"
$productName = "SmartFTP Client";

$app = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -eq $productName -and ($_.Version -eq "{{PackageVersion}}") }
$result = $app.Uninstall();

