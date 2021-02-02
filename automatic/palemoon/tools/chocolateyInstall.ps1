$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-29.0.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-29.0.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '3b02a0ae18577965dd3933e1bc11e5db885c2dd3fcf8cfbb23c1af3af2c1c723'
  checksumType  = 'sha256'
  checksum64    = '4d180abf97dd3bca0e897224ecb765ab1ff1948d05e87232930d8a804fecd241'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
