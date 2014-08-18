$packageName = '{{PackageName}}'
$version = '{{PackageVersion}}'
$fileType = 'exe'
$silentArgs = '/SILENT'
# {\{DownloadUrlx64}\} gets “misused” here as 32-bit download link due to limitations of Ketarin/chocopkgup
$url = '{{DownloadUrlx64}}'

$registryPath32 = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\GnuCash_is1'
$registryPathWow6432 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\GnuCash_is1'

try {

	if (Test-Path $registryPath32) {
		$registryPath = $registryPath32
	}

	if (Test-Path $registryPathWow6432) {
		$registryPath = $registryPathWow6432
	}

	if ($registryPath) {
		$displayName = (Get-ItemProperty -Path $registryPath -Name 'DisplayName').DisplayName
		$installedVersion = $displayName -replace '.+?([\d\.]+)', '$1'
	}

	if ($version -eq $installedVersion) {
		Write-Output "GnuCash $installedVersion is already installed. Skipping download and installation."
	} else {
		Install-ChocolateyPackage $packageName $fileType $silentArgs $url
	}

} catch {
	Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw
}
