$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-33.4.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-33.4.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '741aaabdf6bab3ddc6e5b3b60b920b3cef06666e95e8b31f9f3e36463038c049'
  checksumType  = 'sha256'
  checksum64    = '596bc35bd5c3b941a5cd5cf549ac6582effd9e7af7f6884169450b8e50b84dea'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
