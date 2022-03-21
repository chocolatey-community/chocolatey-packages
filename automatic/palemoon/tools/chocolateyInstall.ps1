$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-30.0.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-30.0.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '850893092bbb5c1e7ff01dd869a00c1e606be843ea1b2edceaf223cc3763b67a'
  checksumType  = 'sha256'
  checksum64    = 'f2adf999be923d2c426f233d59d92ac0ce01b9ce4c8672bff597c462f49c1e7f'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
