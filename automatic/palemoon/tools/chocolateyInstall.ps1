$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-28.8.3.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-28.8.3.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'cb87b78863dda08753ccc706692848166bf4d931ff9ae616ec8fee79219a49e2'
  checksumType  = 'sha256'
  checksum64    = '85aba29c909565fc3ad1734039188335403a3e2c3af940ae17c9fec912e35a70'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
