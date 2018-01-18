$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-27.7.1.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-27.7.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '65455149c4e93611b638980113e1948e4ed13dc283fd218d365974dd0f448d81'
  checksumType  = 'sha256'
  checksum64    = 'a025f2bfef4ba407bca43538b3ed3e7c735b9eeaed63474d0bf64a6705dbad25'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
