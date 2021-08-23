$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-29.4.0.2.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-29.4.0.2.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '3d7ca2137830f59a99a06eccd22931cb40d95c6afb49a01e7dca71d59d1fcaac'
  checksumType  = 'sha256'
  checksum64    = 'a70cd3171d0acbf857cd61f1e2228f931fc85d88f464ca1885ada4670e40f20a'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
