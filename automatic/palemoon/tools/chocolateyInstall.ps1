$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-34.3.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-34.3.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '8186c3d653790a4408f470cd2bd234eda0cc0399ddffeec4006420785dc0a3f2'
  checksumType  = 'sha256'
  checksum64    = '2040d0b1a454e57b38ed9b9020f85bc057469ef34629538bf0e02b1f17887478'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
