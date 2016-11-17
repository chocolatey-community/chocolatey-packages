$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'juju'
  fileType      = 'exe'
  softwareName  = 'Juju'

  checksum      = 'a3756cacb6ed3f4176c9ddd81e01f6381deedc5f26cd74a31e76055e4327b497'
  checksumType  = 'sha256'
  url           = 'https://launchpad.net/juju/2.1/2.1-beta1/+download/juju-setup-2.1-beta1.exe'

  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
