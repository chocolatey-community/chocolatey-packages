$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-31.4.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-31.4.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'cf0a5e0a4d590d0c408ccf6bb77fafe0501bf4ec731a0e7d0e0fa1d5881597d2'
  checksumType  = 'sha256'
  checksum64    = '9a313bc196d855668b34d4cf32fa93d7e72207a638899b6f20a7eb33df6527f7'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
