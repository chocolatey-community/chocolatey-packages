$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-32.4.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-32.4.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'f341889290f6778ede7fdb1c0258a43e1b9a425d9ce99ab2905a3a6dda1f106f'
  checksumType  = 'sha256'
  checksum64    = '39dad4a891ab64c5e028c44d92dd6378883480ea2609ef068c9c499badb055e1'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
