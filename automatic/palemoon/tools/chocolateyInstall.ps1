$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-29.1.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-29.1.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '138463480d48b74992cc96fc00a5e8116d96b9f3d64dd9a5c064dc4a6ed4b4c4'
  checksumType  = 'sha256'
  checksum64    = '0f156fbfb89075c3c94154b42ce06172f9d7ac0f4c8c0309475a21f205ccf877'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
