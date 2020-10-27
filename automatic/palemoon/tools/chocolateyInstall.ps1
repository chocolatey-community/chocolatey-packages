$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-28.15.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-28.15.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'cdce26e2f8a4f63d621b76fa062715ebf4a311bb21c2eb8d93426bf75d7c0391'
  checksumType  = 'sha256'
  checksum64    = '68cb58bb04997e1adb9679ce777474d00db882cf21e4aede84d404843c0e18f4'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
