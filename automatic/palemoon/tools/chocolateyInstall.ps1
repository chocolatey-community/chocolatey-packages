$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-28.7.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-28.7.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'f4918990b694d088e91abbba394f778274b4649661249b41855f6c57c272db04'
  checksumType  = 'sha256'
  checksum64    = '7cc768bb5857446cfc1a07afa75fec5dffdcb8d58da3321698c0f7da988ebbb0'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
