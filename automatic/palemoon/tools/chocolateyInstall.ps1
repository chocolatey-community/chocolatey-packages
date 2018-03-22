$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-27.8.2.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-27.8.2.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'f711c81512f777fdd63de0044d1a62519e251b7d31fa0a2b69155fd6e46353a6'
  checksumType  = 'sha256'
  checksum64    = 'cb0ba41db44e20f8abd93c966340e362609fba694b52ae633d077d05128adec9'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
