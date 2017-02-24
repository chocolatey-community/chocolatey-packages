$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'bluegriffon'
  fileType       = 'exe'
  softwareName   = 'BlueGriffon*'

  checksum       = 'af87a13bfa255f996a857f1936713279d27345b0ac2f8503ea312a82d39c10b7'
  checksumType   = 'sha256'
  url            = 'http://bluegriffon.org/freshmeat/2.3.1/bluegriffon-2.3.1.win32-installer.exe'

  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
