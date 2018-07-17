$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-27.9.4.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-27.9.4.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '40055adcb9656ca448fea387794ecda8aa97f0eaa0c1e20e88c0080bc380fff8'
  checksumType  = 'sha256'
  checksum64    = '14d46b3382ef8f30d8b662d4e7420f441260f6da393e2ca81320fe353ffe0c08'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
