$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-29.1.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-29.1.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'e5f230a95c455f4afc4626062e1aa183af1f09eeea2aed0099404c5743aa3a9c'
  checksumType  = 'sha256'
  checksum64    = '98117c049057b7b0956d6ca77db017f20c06153cf93f3c0dc484cc33b6d27fdd'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
