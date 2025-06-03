$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-33.7.2.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-33.7.2.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '28d5cc8fa689b57bcaa515e3b31fb93cf90ac2896085a29280c146287ad35392'
  checksumType  = 'sha256'
  checksum64    = 'ebb3db0ecd2c5118aedcc0f4a9892167bead427ce38be8433849fc55fc0f9615'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
