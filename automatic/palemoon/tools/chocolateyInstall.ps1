$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-33.8.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-33.8.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '756a7f2df4099206eaa74778efcee7a279102ee7f60b8bf470da124b315c5e08'
  checksumType  = 'sha256'
  checksum64    = '8953ecc5dff9410ede895185fdff7ae4e8476a922d948b8ab64fb9ef948ec6f5'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
