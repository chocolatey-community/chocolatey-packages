#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.7.4/prey-windows-1.7.4-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.7.4/prey-windows-1.7.4-x64.msi'
  checksum               = 'cfc1dcbb7db2f21433bdfdaca1d660db797d1e591293ce3b7da9566f20fe638b'
  checksum64             = 'ceffccea3085382b2c65907d8e21aaba95e8c2bbd36bc3290c2893680a367a50'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs
