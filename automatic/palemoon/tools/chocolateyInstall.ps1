$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://relmirror.palemoon.org/release/palemoon-26.5.0.win32.installer.exe'
  url64         = 'http://relmirror.palemoon.org/release/palemoon-26.5.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'ca051b6b52ccdbb3e20fe91e5bd5d7676a566e184db50daff8c6e885c2a59543'
  checksumType  = 'sha256'
  checksum64    = '2cbec1713ef420b3f5245cf598403d2b05cf0b7532f8a731e7fbb39a128f00de'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
