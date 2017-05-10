$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName = 'seafile-client'
  fileType    = 'msi'
  softwareName = 'Seafile 6.0.6'

  checksum     = '2d7ad48a4b2e24d3ab9719703194c50520fcc084eb5a972986cdc5244ad76f49'
  checksumType = 'sha256'
  url          = 'https://bintray.com/artifact/download/seafile-org/seafile/seafile-6.0.6-en.msi'

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
