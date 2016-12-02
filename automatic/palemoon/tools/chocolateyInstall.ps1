$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://relmirror.palemoon.org/release/palemoon-27.0.2.win32.installer.exe'
  url64         = 'http://relmirror.palemoon.org/release/palemoon-27.0.2.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '31839566e045e14846dbb836785906a413749450721ca8e595368c5381d3b3fc'
  checksumType  = 'sha256'
  checksum64    = '33530db10f40842e2855f69786f3efb28444058777b0188527bdde18649a0d3c'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
