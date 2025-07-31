$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-33.8.1.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-33.8.1.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '557d4bbcca5d0b83c4b77ed25946cbea969d9eb3e251a8f095b27322be065880'
  checksumType  = 'sha256'
  checksum64    = '8b2ef26047cae5ae87389371b4831220cb723bd0a36f3f6b359c2de727966b18'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
