$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-34.3.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-34.3.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'c3682c67d75d74c0f5af9b6cdc1e2b4788d489c95c6c6ddbe18164f8447cab36'
  checksumType  = 'sha256'
  checksum64    = '21c9985d157d4c8c56a9b9d14f3522ae27f0ceb5b28da9e930cdcb1188713f25'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
