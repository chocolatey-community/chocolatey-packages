$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-27.6.0.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-27.6.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '061d3479ad463f6f41fa49d56a6e327baf3eef2ff204414c1895003c65fc5b06'
  checksumType  = 'sha256'
  checksum64    = 'b0db8ec53fab8eefddaa6c499db04a69ccd6a60de1c17ec31c7ccf8a22127505'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
