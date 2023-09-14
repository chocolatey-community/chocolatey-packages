$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-32.4.0.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-32.4.0.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'cb007bef8e41c5820ac8b377fac28c27db23e348d3763b94f63ebebcb7695422'
  checksumType  = 'sha256'
  checksum64    = '0297d7020724fb203be1307b4d0bd15cebd84cda10d53b6be99d0b205fbe1736'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
