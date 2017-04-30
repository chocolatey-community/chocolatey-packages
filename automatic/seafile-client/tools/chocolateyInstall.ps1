$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName = 'seafile-client'
  fileType    = 'msi'
  softwareName = 'Seafile 6.0.3'

  checksum     = '921befb6a75fe213ea8a2e35ce28abfa8a1021ebe53250210bcd669e92f68a42'
  checksumType = 'sha256'
  url          = 'https://bintray.com/artifact/download/seafile-org/seafile/seafile-6.0.3-en.msi'

  silentArgs   = '/passive'
  validExitCodes = @(0)
}

$app = Get-WmiObject -Class Win32_Product | Where-Object {
  $_.Name -match "^$($packageArgs.softwareName)$"
}

if (!$app) {
  Install-ChocolateyPackage @packageArgs
} else {
  Write-Output $(
    "$packageName $version is already installed. " +
    'No need to download an re-install.'
  )
}
