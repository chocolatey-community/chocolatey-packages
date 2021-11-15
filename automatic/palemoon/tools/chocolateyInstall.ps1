$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-29.4.2.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-29.4.2.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'cefed8c5566260799965f2a7988bf3382044e01ab80aa99e5abcd4484196888d'
  checksumType  = 'sha256'
  checksum64    = '2171438c56f2fb7ae7c55ba985e11f62c1970665ff1182d8322503bf745dffd5'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
