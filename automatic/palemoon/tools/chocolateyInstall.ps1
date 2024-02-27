$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-33.0.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-33.0.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'c91470cb43e8d996b50d643a94997e6cb592c1643a38aea96304da7986380070'
  checksumType  = 'sha256'
  checksum64    = 'dd7dcf7e962ab0793c9c6d7591f07fb4d25d3b90a1042d3e8530da7604cf5dfa'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
