$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://relmirror.palemoon.org/release/palemoon-27.1.2.win32.installer.exe'
  url64         = 'http://relmirror.palemoon.org/release/palemoon-27.1.2.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'b629cad71d6c561d6f995b19e94d236b769ecd836bfbfd4648c2bb4e82e4fc09'
  checksumType  = 'sha256'
  checksum64    = '4beaf2acfe23a5a04949adc360c15e9cbfa4bfe01283b430e6a859f47247a2bb'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
