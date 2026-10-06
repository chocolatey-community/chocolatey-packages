$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-35.0.2.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-35.0.2.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '5d0f30cc665e4db101637a16368b35d7a0ad4193848cf66fbac7b05c33389c20'
  checksumType  = 'sha256'
  checksum64    = 'c15e0458e2e65d4cbc91b24452a9a9d745c9a1f0264c570ef4e1b75eee190529'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
