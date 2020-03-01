$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-28.8.4.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-28.8.4.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '0c64a8cd7211585568cfa0b7fba7d7b64a31c621953d443f559e8af887ff458a'
  checksumType  = 'sha256'
  checksum64    = 'e8d2c779ff4b1d32f37584c6ad0310feb78508b8a0fca473654802255eb6e99b'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
