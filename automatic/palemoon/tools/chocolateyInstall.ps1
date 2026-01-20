$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-34.0.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-34.0.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '2843ee4d97eed620ec3dc078c3ca4c02d73a924585ec2b08c8cb8ec66c86d699'
  checksumType  = 'sha256'
  checksum64    = 'ec028e908c0901a392d39aa2ac9823348d7993c77236cf21015aec59ad0f0b11'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
