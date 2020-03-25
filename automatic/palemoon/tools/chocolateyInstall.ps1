$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-28.9.0.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-28.9.0.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '1ae7e312276b563d42f985ae1e359c36e2faf53454cd37f62e6ac00e00143d6c'
  checksumType  = 'sha256'
  checksum64    = 'c3f08e435110e883f043e600507f9b93ac5b66d80c6c1acee66db638195a1e6e'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
