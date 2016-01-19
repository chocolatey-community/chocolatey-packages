$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/S'
$version = '{{PackageVersion}}'
$url = '{{DownloadUrl}}'
$url64 = '{{DownloadUrlx64}}'

$app = Get-WmiObject -Class Win32_Product | Where-Object {
  $_.Name -eq 'Prey Anti-Theft' -and $_.Version -eq $version
}

if ($app) {
  Write-Output $("Prey $version is already installed. " +
    "No need to re-install the same version. " +
    "Skipping download."
  )
} else {
  # Proceed with installation
  Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64
}
