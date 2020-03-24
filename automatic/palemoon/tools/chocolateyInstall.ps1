$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-28.9.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-28.9.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'fd4d2bce872a88991a00744b1dc59e31c6f369ce36cebc3f9adcae580584dbe8'
  checksumType  = 'sha256'
  checksum64    = '6f814cc61a46ba35e63e803892c05a36f618868795effe139decf9ef79aed72a'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
