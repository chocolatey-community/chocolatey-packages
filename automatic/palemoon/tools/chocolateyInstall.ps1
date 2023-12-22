$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-32.5.2.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-32.5.2.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '744d2c5f918bcf186e59e168d86d677f00265730a15ee36fbde0622b55c5b396'
  checksumType  = 'sha256'
  checksum64    = 'a67d25926ec1f837ea9a1c3b96676ac827f3a3ecb50ead91cdd4d39e758d2fe7'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
