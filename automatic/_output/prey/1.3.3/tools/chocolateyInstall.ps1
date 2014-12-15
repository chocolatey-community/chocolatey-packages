$packageName = 'prey'
$fileType = 'exe'
$silentArgs = '/S'
$version = '1.3.3'
$url = 'https://s3.amazonaws.com/prey-releases/node-client/1.3.3/prey-windows-1.3.3-x86.exe'
$url64 = 'https://s3.amazonaws.com/prey-releases/node-client/1.3.3/prey-windows-1.3.3-x64.exe'

try {

  $app = Get-WmiObject -Class Win32_Product | Where-Object {
    $_.Name -eq 'Prey Anti-Theft' -and $_.Version -eq $version}

  if ($app) {
    Write-Host $("Prey $version is already installed. " +
      "No need to re-install the same version. " +
      "Skipping download."
    )
  } else {
    # Proceed with installation
    Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64
  }

} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
