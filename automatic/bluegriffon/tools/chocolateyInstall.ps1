$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'bluegriffon'
  fileType       = 'exe'
  softwareName   = 'BlueGriffon*'

  checksum       = 'a63ddfcf19d1d68c75311964bb0b8ab52e1d41d306b40f8e588851f6d1d62b30'
  checksumType   = 'sha256'
  url            = 'http://bluegriffon.org/freshmeat/2.1.2/bluegriffon-2.1.2.win32-installer.exe'

  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
