$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://relmirror.palemoon.org/release/palemoon-27.1.0.win32.installer.exe'
  url64         = 'http://relmirror.palemoon.org/release/palemoon-27.1.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '24115d11a6d66fb9af1eaf1ee025ef6020e2c1eb148f17109cda588c1ffb82d3'
  checksumType  = 'sha256'
  checksum64    = 'c9f55687949e7d6c8b633ba8b246939afefda7f4e10104306c63623aea6992ea'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
