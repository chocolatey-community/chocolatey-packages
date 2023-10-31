$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-32.5.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-32.5.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '34f92ad033dac1ff38b29441cac6a44eabdbe661dda2a433ce6ab93fc0721579'
  checksumType  = 'sha256'
  checksum64    = 'cfe2bce22d6781b76ed795b0a678ac40c6e57ad6beb5d22cf2f699252c0ef485'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
