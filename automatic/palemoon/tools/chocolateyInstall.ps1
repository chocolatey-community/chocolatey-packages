$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-35.0.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-35.0.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '26184ece2136cd06f72f70a0c2a62a861e764e0cf2bfd0d2663624861f89b90a'
  checksumType  = 'sha256'
  checksum64    = 'ea349ec3cce206ed036c4efad1f362a1ab23b6b431103616256c5b8006fb9152'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
