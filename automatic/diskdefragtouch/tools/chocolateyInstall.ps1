$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'diskdefragtouch'
  fileType               = 'EXE'
  url                    = 'http://downloads.auslogics.com/en/disk-defrag-touch/disk-defrag-touch-setup.exe'
  url64bit               = 'http://downloads.auslogics.com/en/disk-defrag-touch/disk-defrag-touch-setup.exe'
  checksum               = '4861254f1ba99e333034705466cf3510c61093deb4d68de374a6fec95f71e27c'
  checksum64             = '4861254f1ba99e333034705466cf3510c61093deb4d68de374a6fec95f71e27c'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  softwareName           = 'Disk Defrag Touch*'
}
Install-ChocolateyPackage @packageArgs
