$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-28.6.0.1.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-28.6.0.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'd2af3b33f5f5c89792afa07d261a284b6dff2ae4d9f9f85f3cf55bfd74d7206c'
  checksumType  = 'sha256'
  checksum64    = '9526941ff1d437ac94a5fc89ff8d0924a249de44c9413004d9a283b45f5debc2'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
