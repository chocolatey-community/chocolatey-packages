$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-33.1.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-33.1.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '8991299a4c019de1366c4aaa3704a90f8054ad0b41750fce2e804193ff686129'
  checksumType  = 'sha256'
  checksum64    = '17d665e831cf5c9c7c04696ee8b0108f7adc1a58f37266c4467404c7a1a885b7'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
