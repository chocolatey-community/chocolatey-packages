$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-33.9.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-33.9.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'b5b86c79cc861602f97a9ac5845d2698a31f8015851d9f8c0c6cb27076d2626c'
  checksumType  = 'sha256'
  checksum64    = '97163ff9b780271b29cb0840633185fa6fb269c9d7f9cf4d118aaf5823f6572f'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
