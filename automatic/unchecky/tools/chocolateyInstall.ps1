$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'unchecky'
  fileType       = 'exe'
  softwareName   = 'unchecky'

  checksum       = '93b0ddf0225ff5f4a867f038965e7f9e5539e48548b4d17a6ebe03be65279795'
  checksumType   = 'sha256'
  url            = 'https://unchecky.com/files/unchecky_setup.exe'

  silentArgs     = '-install'
  validExitCodes = @(0)
}

# unchecky_setup.exe -install -path <installation_path> [-lang <unchecky_language>] - get command line arguments
Install-ChocolateyPackage @packageArgs
