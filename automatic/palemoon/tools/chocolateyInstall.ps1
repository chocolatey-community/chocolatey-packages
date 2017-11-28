$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-27.6.2.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-27.6.2.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '97b520a197672700904d35310f3f2a70c7dbfc90cd90651bb6b2b2a6c859dadc'
  checksumType  = 'sha256'
  checksum64    = 'fe399910cb838cfba580f8d0e61de765113d959afa68986e8c8d22d57f6804d3'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
