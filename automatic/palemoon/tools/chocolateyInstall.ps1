$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-27.9.2.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-27.9.2.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '4df0dbd0fc253da61aa16edf66e9bdcadf5104270124afe4130b6d303ccbfa28'
  checksumType  = 'sha256'
  checksum64    = '9b8f5ca20ecb695a9946f7b21d44cef7f2570091a37481f1bd76c47c7201c680'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
