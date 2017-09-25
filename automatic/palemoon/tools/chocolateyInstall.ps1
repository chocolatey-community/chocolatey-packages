$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-27.4.2.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-27.4.2.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '8f9cce4cf63ae15d2b0800620d310ffd633dfe91cc739bfc2925ece00dc3bff1'
  checksumType  = 'sha256'
  checksum64    = 'f3b95c4eba6757fc888bddab78dde40ac4ddb0d82bba16a6a4e3d3e1f916c39a'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
