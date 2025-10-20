$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'supertuxkart'
  fileType       = 'exe'
  url            = 'https://github.com/supertuxkart/stk-code/releases/download/1.5/SuperTuxKart-1.5-installer-i686.exe'
  url64          = 'https://github.com/supertuxkart/stk-code/releases/download/1.5/SuperTuxKart-1.5-installer-x86_64.exe'
  checksum       = '9f6685a728952f822598ec8ab9ff9c04f35d72203559786aec22de1ffdb8c79b'
  checksum64     = '5a9c685970a04140991ced3193d8168e335d414583edcad57ca5ef7cd72f0ab0'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'supertuxkart*'
}
Install-ChocolateyPackage @packageArgs
