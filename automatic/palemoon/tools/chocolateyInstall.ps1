$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-27.4.2.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-27.4.2.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '90b72bf64ca7ce51437f91b48136d65369e9e480266296d0932be6fd1c6cc595'
  checksumType  = 'sha256'
  checksum64    = '5139d492782a5d17176faeb18432c7aa5a49f08c8c6593ce4c73a8d4afe1f165'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
