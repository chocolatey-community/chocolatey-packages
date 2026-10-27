$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-35.0.3.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-35.0.3.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '72d4ac8a46f54716efb40b7da364404f20676fc5d2a21a8785c682bcb65dcbe6'
  checksumType  = 'sha256'
  checksum64    = '585c2fa5cda8f717f942ca66c13144f17feeabcc788f3b5eaa5c432d849131a9'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
