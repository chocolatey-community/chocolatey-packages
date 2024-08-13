$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-33.3.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-33.3.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'eae4e69e1fec5831e70cdf24e28039071a6337b6bf6b36b5be3f1697ca2ba6ea'
  checksumType  = 'sha256'
  checksum64    = '6e34125dc22439a7480d17cb3c21c2b4b0213d11883869c950e3f699391b1469'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
