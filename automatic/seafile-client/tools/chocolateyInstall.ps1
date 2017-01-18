$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName = 'seafile-client'
  fileType    = 'msi'
  softwareName = 'Seafile 6.0.2'

  checksum     = '48408baed7683335ce464e418dd20a3d4031aa3dafffc2a7fb20a7c20ec6320c'
  checksumType = 'sha256'
  url          = 'https://bintray.com/artifact/download/seafile-org/seafile/seafile-6.0.2-en.msi'

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
