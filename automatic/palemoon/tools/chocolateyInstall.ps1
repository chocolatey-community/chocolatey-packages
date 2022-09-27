$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-31.3.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-31.3.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '6e799b195d7b77aea7c59d3d6846b18301801797d4480b656a49e9ceb00776a8'
  checksumType  = 'sha256'
  checksum64    = '7d6a237d4ffae331752e8d49350871355350ab19c843bfcb9679a8da0bf1333f'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
