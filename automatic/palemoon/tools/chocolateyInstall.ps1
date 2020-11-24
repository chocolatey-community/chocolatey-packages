$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-28.16.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-28.16.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '1116fd126532e0ef1dda6ed8ac00c20e968e41ca0b59dbdc657e5578bf9e7234'
  checksumType  = 'sha256'
  checksum64    = '8d56e89088a5dc88fd39a3e759a290d97e857732b3081c87ff314f5e459452d5'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
