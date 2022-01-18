$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-29.4.4.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-29.4.4.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '5b676f1a1a1663ef35c71bd1fe8ad8d2a3f279e6be40a17905c9c95177349577'
  checksumType  = 'sha256'
  checksum64    = '916f89f56a65ec299a0be4a191f8892e0b953a5445f12291b06466c31838e30e'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
