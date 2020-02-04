$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-28.8.2.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-28.8.2.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '06c21da264b9849bbf8ac211c186a5e53fa55d457d314ea6e54b71ba21c804be'
  checksumType  = 'sha256'
  checksum64    = 'c9fef0818f56f871010cabd92e77513ee9de315f94018541286e8daa70c02d69'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
