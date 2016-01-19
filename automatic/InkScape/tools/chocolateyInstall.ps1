$packageName = '{{PackageName}}'
$packageVersion = '{{PackageVersion}}'

$url = '{{DownloadUrl}}'
$url64 = '{{DownloadUrlx64}}'
$installerType = 'msi'
$installArgs = '/passive /norestart'

$app = Get-WmiObject -Class Win32_Product | Where-Object {
  $_.Name -match '^Inkscape [\d\.]+$'
}

if ($app.Version -eq $packageVersion) {
  Write-Output $(
    'Inkscape ' + $app.Version + ' is already installed. ' +
    'No need to download and install again.'
  )
} else {
  Install-ChocolateyPackage $packageName $installerType $installArgs $url $url64
}
