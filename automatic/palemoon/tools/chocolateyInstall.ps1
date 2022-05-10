$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-31.0.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-31.0.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '43fa39644257e94024b454d01052f0cef5a022e3972a576e9070ea20a0e96ab0'
  checksumType  = 'sha256'
  checksum64    = '063bc50c431a352f69387815c6076c806961c08c61785539ca6f610e7fdfdd38'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
