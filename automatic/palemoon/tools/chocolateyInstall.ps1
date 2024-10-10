$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-33.4.0.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-33.4.0.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '87cc0ad75986bf9b7fa1f087a2ea33fe7772fa9cd80aa97ea0e8cb3f4cc0bd84'
  checksumType  = 'sha256'
  checksum64    = '22ad5d0c73cef554e435bd0db11167ba32ffb7594a6dbd9d2f1a24ba55039e4c'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
