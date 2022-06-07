$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-31.1.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-31.1.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '57a197c1c619071a4918302d80e2bacd460562cf79627b33d9ae3a81d37979e8'
  checksumType  = 'sha256'
  checksum64    = '9b76d7cfaefa41e62853e67b2b9d26e2d432fdcc63959db3d7f14e4db0001df3'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
