$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://relmirror.palemoon.org/release/palemoon-27.1.1.win32.installer.exe'
  url64         = 'http://relmirror.palemoon.org/release/palemoon-27.1.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'e8a9662192925141ac5118af31b1e94f13708f7582a835170063c291ed5daf71'
  checksumType  = 'sha256'
  checksum64    = '0a02089cbe77db4295033a65653c19a78904f20217057c5be85625f05696479f'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
