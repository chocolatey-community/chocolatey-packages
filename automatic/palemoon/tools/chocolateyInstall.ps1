$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-33.2.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-33.2.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'a1d444370757d9d43e642cc524f1aff08b6de696352f965973d2e4b73ae1ecfb'
  checksumType  = 'sha256'
  checksum64    = '7e67d157327ccf464a36a29ccbb6d87c47d6e43f2025e4ab38c38f0d7dab78c1'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
