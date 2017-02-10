$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'unchecky'
  fileType       = 'exe'
  softwareName   = 'unchecky'

  checksum       = '7343662791ebe9bdf1bcfd833d56a35d6018e050fdeb3f70807db1c8f13d2ecd'
  checksumType   = 'sha256'
  url            = 'https://unchecky.com/files/unchecky_setup.exe'

  silentArgs     = '-install'
  validExitCodes = @(0)
}

# unchecky_setup.exe -install -path <installation_path> [-lang <unchecky_language>] - get command line arguments
Install-ChocolateyPackage @packageArgs
