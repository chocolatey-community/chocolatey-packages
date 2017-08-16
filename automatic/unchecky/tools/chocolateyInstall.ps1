$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'unchecky'
  fileType       = 'exe'
  softwareName   = 'unchecky'

  checksum       = '307a5448402fe4adf3eb48a8e54eedceccb5b23520e0dffc297a2a45e33bbd4d'
  checksumType   = 'sha256'
  url            = 'https://unchecky.com/files/unchecky_setup.exe'

  silentArgs     = '-install'
  validExitCodes = @(0)
}

# unchecky_setup.exe -install -path <installation_path> [-lang <unchecky_language>] - get command line arguments
Install-ChocolateyPackage @packageArgs
