$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-29.4.0.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-29.4.0.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '6311c2be97130c0a7916e356d66f406d83c3ffd65c47bbb668e33f3d90617b90'
  checksumType  = 'sha256'
  checksum64    = '75eac09220b7380186d222f2b5992394a3400141691a7dbc3a7a8ee16419ab91'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
