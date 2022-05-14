$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    ='sauerbraten'
  fileType       = 'exe'
  softwareName   = 'Sauerbraten'

  checksum       = '3424EB2B7DA089B91D3F3B2259F737B4BD507E5C12B28EA1B7FC4D5777755B26'
  checksumType   = 'sha256'
  url            = 'https://sourceforge.net/projects/sauerbraten/files/sauerbraten/2020_11_29/sauerbraten_2020_12_21_windows.exe/download'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
