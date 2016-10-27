$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'unchecky'
  fileType       = 'exe'
  softwareName   = 'unchecky'

  checksum       = '727269090f5cf495897e8e0acd51c76c8230dff31e041d3d064eee24798d6cc3'
  checksumType   = 'sha256'
  url            = 'https://unchecky.com/files/unchecky_setup.exe'

  silentArgs     = '-install'
  validExitCodes = @(0)
}

# unchecky_setup.exe -install -path <installation_path> [-lang <unchecky_language>] - get command line arguments
Install-ChocolateyPackage @packageArgs
