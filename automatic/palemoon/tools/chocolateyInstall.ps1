$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-27.5.1.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-27.5.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'ee04d423585c9298561b7c98a3ba3b3437c42fb4215166ff232cd361bb6d3dfa'
  checksumType  = 'sha256'
  checksum64    = '1e3b859ecf7e6968c731ada8a59a0686551b6762c0a34fe1f23ac3d8edb163bf'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
