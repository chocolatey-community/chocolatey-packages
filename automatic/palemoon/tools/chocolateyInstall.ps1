$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-27.7.0.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-27.7.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '2a3665e0785471470de9f1e1db51d187fad2d2812c38cd5407b64851c4fab51a'
  checksumType  = 'sha256'
  checksum64    = 'bdad51df07170cd096ecbce0d06e992b90cc35725d80a1886965aa2b81fc8b51'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
