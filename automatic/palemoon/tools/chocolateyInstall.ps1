$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-29.4.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-29.4.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '2907fc5fb7a5f719d788014f5d950ab443cdff0b735602125f403aa6a5426a85'
  checksumType  = 'sha256'
  checksum64    = '3494c709d0f41cfb78cfe5baf860a5efcf4c00cfb9c32bcc98f245f09d4354fa'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
