$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'ext2fsd'
  fileType               = 'exe'
  url                    = 'https://sourceforge.net/projects/ext2fsd/files/Ext2fsd/0.69/Ext2Fsd-0.69.exe/download'
  checksum               = ''
  checksumType           = 'sha256'
  silentArgs             = '/VERYSILENT /NORESTART'
  validExitCodes         = @(0)
  softwareName           = 'ext2fsd*'
}
Install-ChocolateyPackage @packageArgs
