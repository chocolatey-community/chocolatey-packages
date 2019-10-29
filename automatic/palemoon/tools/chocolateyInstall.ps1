$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-28.7.2.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-28.7.2.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'ffe9734b4b366f277c314bf0a78e0d6cfa550b865ae02a3272b00b8c36d0c161'
  checksumType  = 'sha256'
  checksum64    = '2a331b1804f044a4ffadfc52400c405085c4cadccb1c84d1c4879c7b081b27aa'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
