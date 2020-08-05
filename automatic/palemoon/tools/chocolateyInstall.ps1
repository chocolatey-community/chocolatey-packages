$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-28.12.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-28.12.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '7495bb292eee011bac5660a8ad4da8e643d3e235728beb4d676687f3de5c45db'
  checksumType  = 'sha256'
  checksum64    = 'aaa1cc8f9e508631bf01d65a978d2beb21d7f27e76bd01b72e2822b40718d7f5'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
