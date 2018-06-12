$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-27.9.3.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-27.9.3.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '3652be66a06d57acc7fa45ba7359876dee90fc35f37cab6e2a80506b8dba9765'
  checksumType  = 'sha256'
  checksum64    = '2257f0d48faa3578974a0bbf6ebb90755a2feed68383fbf89507df821fd1bb3b'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
