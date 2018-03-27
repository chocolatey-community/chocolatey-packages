$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'musescore'
  fileType               = 'msi'
  url                    = 'http://ftp.osuosl.org/pub/musescore/releases/MuseScore-2.2/MuseScore-2.2.msi'
  url64bit               = 'http://ftp.osuosl.org/pub/musescore/releases/MuseScore-2.2/MuseScore-2.2.msi'
  checksum               = 'ef50bfc7e4e915fae79bae36a4aed6b2db423956a32a154ae9cbc8d09ae1e023'
  checksum64             = 'ef50bfc7e4e915fae79bae36a4aed6b2db423956a32a154ae9cbc8d09ae1e023'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'musescore*'
}
Install-ChocolateyPackage @packageArgs
