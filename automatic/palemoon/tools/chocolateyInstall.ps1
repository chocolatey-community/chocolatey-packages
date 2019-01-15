$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-28.3.0.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-28.3.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'f3891fd5ee1d98081fd3d97395749b1b60e14dce3b97f20b412881635efe4ed6'
  checksumType  = 'sha256'
  checksum64    = 'e15a88b9ef1e89d965a894797d703ff5ce56c1deed9c49bb12c7c33c12b8dc27'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
