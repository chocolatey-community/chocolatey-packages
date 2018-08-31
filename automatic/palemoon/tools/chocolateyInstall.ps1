$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-28.0.1.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-28.0.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '9e35bca4c68fb0f15c58f99b6d4ba7a2a1de4e94d617cdb8ca265c50d4c0fdb2'
  checksumType  = 'sha256'
  checksum64    = '31ce73c8b0200a21f9a6318a224a7bcdabdade1546d2ec8d48d6bf123f39a886'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
