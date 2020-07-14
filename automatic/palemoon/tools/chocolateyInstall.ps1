$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-28.11.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-28.11.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'e4c678296dfe014dee46f3267ff2679605a9c83f0b1facb2b23f9169e2c608b4'
  checksumType  = 'sha256'
  checksum64    = 'aea06dec9acd60812000a2a751d37005285b811c9eccff2bce62530caa39623f'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
