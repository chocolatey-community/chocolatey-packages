$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-32.3.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-32.3.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'c18ae5f0248f54abe5264da4ede4f930dcb81bd251949b8cbb7f3f61bac4fc9f'
  checksumType  = 'sha256'
  checksum64    = 'd7bbf6c97a228296caa659d63ffc56fd582922eb46ef846d3eec656325485d4a'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
