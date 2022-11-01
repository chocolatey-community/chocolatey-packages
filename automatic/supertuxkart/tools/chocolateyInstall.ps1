$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'supertuxkart'
  fileType       = 'exe'
  url            = 'https://github.com/supertuxkart/stk-code/releases/download/1.4/SuperTuxKart-1.4-installer-i686.exe'
  url64          = 'https://github.com/supertuxkart/stk-code/releases/download/1.4/SuperTuxKart-1.4-installer-x86_64.exe'
  checksum       = '6048a159e6affb5fd880b14f6523efc19b9e19a3802e53f1226131d15678bde5'
  checksum64     = '907a85f34a5355898a9187125affe9b4cdecf8f108c7c3a6a9d9a8ce7950967d'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'supertuxkart*'
}
Install-ChocolateyPackage @packageArgs
