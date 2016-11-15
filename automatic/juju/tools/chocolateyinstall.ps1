$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'juju'
  fileType      = 'exe'
  softwareName  = 'Juju'

  checksum      = '22224346ce7e81cb406502c7307925a4fc6a0d8977305b134cd4090efd88a2a2'
  checksumType  = 'sha256'
  url           = 'https://launchpad.net/juju/2.0/2.0.2/+download/juju-setup-2.0.2-signed.exe'

  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
