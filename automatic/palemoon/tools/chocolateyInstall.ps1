$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-30.0.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-30.0.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'e844e30bf3a554907dda2eaf282e87d16a24993fbe5187f3d973aaf2745b1d09'
  checksumType  = 'sha256'
  checksum64    = 'cecb33f8c238c82d9a4fd0076b573624d35b476fd984d0ee2c6747b8724d1304'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
