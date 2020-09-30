$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-28.14.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-28.14.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'c589bbbdeade7af663d6dcad3209dda80a8cbaa9bfd8ea74871ece6cf49e12e1'
  checksumType  = 'sha256'
  checksum64    = 'b4200e5ba30c390a059e0278a4dbedbf26545f78fc9c9e739fd74a9dc097bf16'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
