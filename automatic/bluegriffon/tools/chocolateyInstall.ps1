$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'bluegriffon'
  fileType       = 'exe'
  softwareName   = 'BlueGriffon*'

  checksum       = '3119bb380d335baccc8fba5d4d023e566600c564b5e76dde1774a84ab032c6d1'
  checksumType   = 'sha256'
  url            = 'http://bluegriffon.org/freshmeat/2.2/bluegriffon-2.2.win32-installer.exe'

  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
