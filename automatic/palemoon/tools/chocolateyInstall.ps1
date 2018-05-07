$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-27.9.1.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-27.9.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '74cbc558846d8db6ad305e3c0d91e65b728023cf3766247f380c5a9c7e7eeaf4'
  checksumType  = 'sha256'
  checksum64    = '500dc3ff9f47491427c5764f3a248b5a9888030bb4157d6d553534b732dc2de9'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
