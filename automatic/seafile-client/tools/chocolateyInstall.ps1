$packageName = '{{PackageName}}'
$fileType = 'msi'
$silentArgs = '/passive'
$url = '{{DownloadUrl}}'
$version = '{{PackageVersion}}'

$app = Get-WmiObject -Class Win32_Product | Where-Object {
  $_.Name -match "^Seafile ${version}$"
}

if (!$app) {
  Install-ChocolateyPackage $packageName $fileType $silentArgs $url
} else {
  Write-Output $(
    "$packageName $version is already installed. " +
    'No need to download an re-install.'
  )
}
