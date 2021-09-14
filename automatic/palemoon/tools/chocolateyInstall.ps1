$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-29.4.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-29.4.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '995ee0f57a09cdd198478a8a46248ead11e99e6782905faee8c614c6455673db'
  checksumType  = 'sha256'
  checksum64    = 'd06b78df63bbd0e86c382d0e47d3d55bd9e0ba9b7e626f8ba5f76ecc2b109df8'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
