$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-28.5.1.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-28.5.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '93ba46a0b3f249caf31d61ed2a62ab1e13dd9bf3b329412571b765ad10c06ea5'
  checksumType  = 'sha256'
  checksum64    = '474d821dc5fea0e6efe1b37c4315178ddb7462f8403d9d7fe21eb92fb4f1331d'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
