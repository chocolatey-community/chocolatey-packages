$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-28.9.3.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-28.9.3.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '01b21e58971fbeb7b38ea5b574365c943847556e03e5e337792920d3ade48eab'
  checksumType  = 'sha256'
  checksum64    = '491df6ce64a51d70cca337a6a81ba95b11b748e580d9f9ea9044d7e0f92ddb88'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
