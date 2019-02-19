$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-28.4.0.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-28.4.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'f65df9b757364f728c84beb3740302a7ea8fa36a67516692a681ec7a9619fca0'
  checksumType  = 'sha256'
  checksum64    = 'dc849bcd71fdef590e0ccc051a754e6cce25aafe615831368ab9b5cb7732a972'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
