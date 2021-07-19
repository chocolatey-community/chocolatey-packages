$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-29.3.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-29.3.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '0d05bf82423f4d781304f3d794336942f47492ac3bec2b0ee1bb7905197676bc'
  checksumType  = 'sha256'
  checksum64    = '7791d58979f50e7aac25cb13c6b7d42f6512df83ec8a9ba530e2156c0c5233e5'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
