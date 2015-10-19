$packageName = '{{PackageName}}'
$packageVersion = '{{PackageVersion}}'

$url = '{{DownloadUrl}}'
$url64 = '{{DownloadUrlx64}}'
$installerType = 'msi'
$installArgs = '/passive /norestart'

try {

  $app = Get-WmiObject -Class Win32_Product | Where-Object {
    $_.Name -match '^Inkscape [\d\.]+$'
  }

  if ($app.Version -eq $packageVersion) {
    Write-Host $(
      'Inkscape ' + $app.Version + ' is already installed. ' +
      'No need to download and install again.'
    )
  } else {
    Install-ChocolateyPackage $packageName $installerType $installArgs $url $url64
  }

} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
