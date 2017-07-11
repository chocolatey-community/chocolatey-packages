$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'musescore'
  fileType               = 'msi'
  url                    = 'http://ftp.osuosl.org/pub/musescore/releases/MuseScore-2.1/MuseScore-2.1.msi'
  url64bit               = 'http://ftp.osuosl.org/pub/musescore/releases/MuseScore-2.1/MuseScore-2.1.msi'
  checksum               = '9fd7c2372896ddbd9c727e33d43e97f8f66678cf662a0a64c51435bffe8c25b2'
  checksum64             = '9fd7c2372896ddbd9c727e33d43e97f8f66678cf662a0a64c51435bffe8c25b2'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'musescore*'
}
Install-ChocolateyPackage @packageArgs
