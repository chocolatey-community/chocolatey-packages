$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'unchecky'
  fileType       = 'exe'
  softwareName   = 'unchecky'

  checksum       = '25896931db48f0f4c9e3681720fb7c89b531d912ce5f11d596078f8d917126b7'
  checksumType   = 'sha256'
  url            = 'https://unchecky.com/files/unchecky_setup.exe'

  silentArgs     = '-install'
  validExitCodes = @(0)
}

# unchecky_setup.exe -install -path <installation_path> [-lang <unchecky_language>] - get command line arguments
Install-ChocolateyPackage @packageArgs
