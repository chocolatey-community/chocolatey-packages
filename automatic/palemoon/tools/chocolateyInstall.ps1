$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-35.0.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-35.0.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '84d285bff7733643f40fd686042a4c2d0f5aa88a90f8745a2346bbad02e06ffc'
  checksumType  = 'sha256'
  checksum64    = 'c2b6b2d013d28ef05d4a4fe6aeed9940a0ea52444e040c30a06ca526bbc04f0a'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
