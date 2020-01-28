$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-28.8.2.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-28.8.2.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '6e8bf9affb9668f4b4e957ae0f8cc326055c9ff8d0e3ca3eb5d3e3390b3d0586'
  checksumType  = 'sha256'
  checksum64    = '73408894d7342cc276f1f3b465691e9f486e9a40f19d690a89a31dfbebf01403'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
