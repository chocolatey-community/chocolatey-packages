$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-27.9.0.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-27.9.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'b324db9c0a1ee42fa75ca722b7d2c84e4f0ef9adf22dc25588fce16cdf02ada8'
  checksumType  = 'sha256'
  checksum64    = '5a52f732901a23def3e2b7d8b1bb83d7f51c1797ec5d2b2bb719e09f6a2433bb'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
