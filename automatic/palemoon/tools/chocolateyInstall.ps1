$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-31.3.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-31.3.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '1edf8afa373c4e2b4fc3dd3356d1a1eba8af9d5f68a15c9d8bcf98178ae93469'
  checksumType  = 'sha256'
  checksum64    = 'f903365b0926493574a7e7abded3f10394fb0ac8ecde4f1c31b9c56873f0d52f'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
