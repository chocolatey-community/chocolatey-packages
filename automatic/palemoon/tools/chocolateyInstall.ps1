$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-31.4.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-31.4.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '9fd675327bd22338829a39eaa7570058690a4b49d24f53b8042831b0d02cafc3'
  checksumType  = 'sha256'
  checksum64    = 'cd1db112c39745f711f1cdc5b6235f6646c3f0d339e414405e16dbb616e7765a'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
