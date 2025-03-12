$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-33.6.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-33.6.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'bed79adcc3b728e3077b34d949777e4ad911502c5ec2fc11ffee9bab6b05022c'
  checksumType  = 'sha256'
  checksum64    = 'f6332ba049dcee220774ebce80e72f3061c4e69e9938231186d36fcf6250391f'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
