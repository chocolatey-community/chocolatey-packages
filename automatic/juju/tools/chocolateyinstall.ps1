$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'juju'
  fileType      = 'exe'
  softwareName  = 'Juju'

  checksum      = 'affc683c79550c2d60f53e73dbdec5dd9317827f979cace0b7aa296aa8a24f8b'
  checksumType  = 'sha256'
  url           = 'https://launchpad.net/juju/2.1/2.1-beta2/+download/juju-setup-2.1-beta2.exe'

  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
