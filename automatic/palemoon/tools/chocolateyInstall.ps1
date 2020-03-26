$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-28.9.0.2.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-28.9.0.2.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'd7c79918c773405e7298718ead0210ecf876fac451820e7217ba209fdb2937d4'
  checksumType  = 'sha256'
  checksum64    = 'c06e08e0264ef9a1421ad07a33bbb353df7bfd657aee3f4ef327bd8fd8e44f8f'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
