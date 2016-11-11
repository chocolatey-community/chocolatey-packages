$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'ext2fsd'
  fileType               = 'exe'
  url                    = 'https://sourceforge.net/projects/ext2fsd/files/Ext2fsd/0.68/Ext2Fsd-0.68.exe/download'
  url64bit               = 'https://sourceforge.net/projects/ext2fsd/files/Ext2fsd/0.68/Ext2Fsd-0.68.exe/download'
  checksum               = '1546264153c2cf73d3119d3ce0db2d2302aac45a14596a00ead6e39cc72cc05e'
  checksum64             = '1546264153c2cf73d3119d3ce0db2d2302aac45a14596a00ead6e39cc72cc05e'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT /NORESTART'
  validExitCodes         = @(0)
  softwareName           = 'ext2fsd*'
}
Install-ChocolateyPackage @packageArgs
