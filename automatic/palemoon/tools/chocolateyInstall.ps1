$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-33.7.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-33.7.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '5615b9f846d20445a6c9103c2fcc1c63cd3218db42c48b733852bb91cbc2f053'
  checksumType  = 'sha256'
  checksum64    = 'd0648b3f093afe288462d251454fc340472f60ed7517610a4cb78c5dee963f02'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
