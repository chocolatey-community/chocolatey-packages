$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName = 'seafile-client'
  fileType    = 'msi'
  softwareName = 'Seafile 6.0.7'

  checksum     = 'e76626742272ac04060d002b7f83f5f25d2f704723b6192751e6ac104140b5e1'
  checksumType = 'sha256'
  url          = 'https://download.seadrive.org/seafile-6.0.7-en.msi'

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
