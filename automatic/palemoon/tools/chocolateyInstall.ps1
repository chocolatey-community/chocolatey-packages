$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-28.2.2.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-28.2.2.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '27b37f22f82d763a01b8768356a0bc8e970a68a27770385ebbbe4c9b70490889'
  checksumType  = 'sha256'
  checksum64    = '83f8f0fecba3a11969ab857178359a09ca50397c694d495652247c9312c90049'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
