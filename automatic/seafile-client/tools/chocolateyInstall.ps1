$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName = 'seafile-client'
  fileType    = 'msi'
  softwareName = 'Seafile 6.0.1'

  checksum     = 'a3c4d69cf2a3ca56b3a3c5aaa7a80e29499294ee9f994b17d9b352f245ed12cd'
  checksumType = 'sha256'
  url          = 'https://bintray.com/artifact/download/seafile-org/seafile/seafile-6.0.1-en.msi'

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
