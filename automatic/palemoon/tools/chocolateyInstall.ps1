$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-27.7.2.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-27.7.2.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '2cb56e584bc891917de858aad4f0e982e0741dbe5bd740117d739d8655063b5e'
  checksumType  = 'sha256'
  checksum64    = 'acdfa78c197be36904a0439b57f7f60a472b0f60e8f55c8ecdea274823cfe5a8'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
