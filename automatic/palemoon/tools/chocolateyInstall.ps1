$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-33.4.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-33.4.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '47c25b2c1f482d8600607e19cf66cac6f875cd96597cfb2af695f25798cfdb64'
  checksumType  = 'sha256'
  checksum64    = '77dfaffc895f55712570ddcba77089c2c752bb495fa388523abceeb33c90b257'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
