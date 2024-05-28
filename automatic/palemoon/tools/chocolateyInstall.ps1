$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-33.1.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-33.1.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '1bf9c5b9d55ace6ea257a2b4abbed085a5239e65ee490c65959bd8449006c4b0'
  checksumType  = 'sha256'
  checksum64    = '298870825546a1dd23e5f249ab02f4402209c2b70870f6e09450fc2fd139ff06'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
