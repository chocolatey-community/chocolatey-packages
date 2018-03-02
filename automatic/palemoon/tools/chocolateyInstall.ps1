$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-27.8.0.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-27.8.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '8bd3651135903a6ebf03c5355695b17c2c3e3540be617512c12a0dc754d8a315'
  checksumType  = 'sha256'
  checksum64    = '8a1cd407a91561e2113abb89c29968b627abae89424a4afc02ec83a4a24c20bf'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
