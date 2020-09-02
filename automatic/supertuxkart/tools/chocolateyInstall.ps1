$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'supertuxkart'
  fileType       = 'exe'
  url            = 'https://github.com/supertuxkart/stk-code/releases/download/1.2/SuperTuxKart.1.2.0.installer-32bit.exe'
  url64          = 'https://github.com/supertuxkart/stk-code/releases/download/1.2/SuperTuxKart.1.2.0.installer-64bit.exe'
  checksum       = '2274550a2b420b1a80f5acfbc316f811bc1c5fd78370a673ec873c4d737201cf'
  checksum64     = '27427c615edcb7424585b62d9299f890d41a2da9e666d477a2145c57527418c2'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'supertuxkart*'
}
Install-ChocolateyPackage @packageArgs
