$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://relmirror.palemoon.org/release/palemoon-27.0.1.win32.installer.exe'
  url64         = 'http://relmirror.palemoon.org/release/palemoon-27.0.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '0ff71bbe02031f255b9389f42297e2cd9fb3ed656c40724b184808c56c3af47d'
  checksumType  = 'sha256'
  checksum64    = '8f9bc672cf2f84c096315bb5d7f91f7d4afcb166c591a15e39dac8fb9045755b'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
