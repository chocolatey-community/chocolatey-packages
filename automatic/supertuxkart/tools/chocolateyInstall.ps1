$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'supertuxkart'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/supertuxkart/files/SuperTuxKart/1.1/SuperTuxKart%201.1.0%20installer-32bit.exe/download'
  url64          = 'https://sourceforge.net/projects/supertuxkart/files/SuperTuxKart/1.1/SuperTuxKart%201.1.0%20installer-64bit.exe/download'
  checksum       = 'a5a6d667663ed9772ab29261983bca42c52f0b86ab09c974d3868250288f6a4a'
  checksum64     = '8fc8b765d00d95de3e5c467b73e03ce55e7e20285a7b8f86f2e4edfc5fff4ac6'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'supertuxkart*'
}
Install-ChocolateyPackage @packageArgs
