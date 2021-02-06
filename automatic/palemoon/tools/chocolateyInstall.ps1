$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-29.0.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-29.0.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'e2a6aa86a40a28b2898c28b9f6010d77f36ef9ad0ee661108f7c72f4791222df'
  checksumType  = 'sha256'
  checksum64    = 'cf228868378d16bb6dc31b4efa2c3591825db06eb01456bc5cac473a446c7f21'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
