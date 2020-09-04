$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-28.13.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-28.13.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'b91d83c1adeedb56546c9817cb249c70b27e19cb05c8cfbe33cb0239a7cd0110'
  checksumType  = 'sha256'
  checksum64    = '302685d8bcf3d6d9a12d5a96224df1b05dbe2665347fb0d8d4c71fba32eb47f5'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
