$packageName = '{{PackageName}}'
$url = '{{DownloadUrl}}'
$url64 = '{{DownloadUrlx64}}'

try {

	$binRoot = Get-BinRoot
	$instDir = Join-Path $binRoot $packageName


	# Detect if sqlite package uses old/deprecated installation path
	$oldInstDir = Join-Path $env:ChocolateyInstall 'bin'
	$sqliteFiles = @('sqlite3.dll', 'sqlite3.def')
	foreach ($file in $sqliteFiles) {
		$oldFilePath = Join-Path $oldInstDir $file
		if (Test-Path $oldFilePath) {
			$usesOldPath = $true
		}
	}
	if ($usesOldPath) {
		Write-Host $(
			"Old installation directory for $packageName detected ($oldInstDir). " +
			"If you want to use the new installation directory (ChocolateyBinRoot\$packageName), " +
			"remove the sqlite*.dll sqlite*.def files from your old installation " +
			"directory and reinstall this package with the ‘-force’ parameter."
		)

		$instDir = $oldInstDir
	}

	Install-ChocolateyZipPackage $packageName $url $instDir $url64

	if (!($usesOldPath)) {
		Install-ChocolateyPath $instDir 'Machine'
	}

} catch {
	Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw
}
