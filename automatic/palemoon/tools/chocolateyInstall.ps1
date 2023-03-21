$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-32.1.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-32.1.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'b835150b0aef83e3d168bc7a55b4fcff11b4ec87390e3c6e5a792498820cd9bb'
  checksumType  = 'sha256'
  checksum64    = '4430a2d744620d6b85eb842715e72e698937e2e6e05fd02831b5da013b642d0f'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
