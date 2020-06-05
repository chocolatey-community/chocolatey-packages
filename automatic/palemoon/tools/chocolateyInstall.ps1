$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-28.10.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-28.10.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '46fa2ce1786c51121f20b5d2eaa14020980cfd88ae728327c3af3529c5fcb72e'
  checksumType  = 'sha256'
  checksum64    = '538e524b5343a851750bd6fe0c95c30499675ae7de1c49433942146731adfea2'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
