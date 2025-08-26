$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-33.8.2.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-33.8.2.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '4c17a030bebf745953df7baf09b9d229546c30a0c365111ec12375c5f77f1232'
  checksumType  = 'sha256'
  checksum64    = 'ea141ba0d45547fd7d6120e2f6aa954b4085c13c9f1b092839104d6c98210ffa'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
