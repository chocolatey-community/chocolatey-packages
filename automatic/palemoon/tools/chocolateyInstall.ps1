$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-33.8.1.2.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-33.8.1.2.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '89fe1ac82bb25937ae102631884538289688817d84fdb5631c78f28c28485740'
  checksumType  = 'sha256'
  checksum64    = '9837c4027828b1a711ff8b7eb8323d70b8da112f22ba0e7227f3432677793af7'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
