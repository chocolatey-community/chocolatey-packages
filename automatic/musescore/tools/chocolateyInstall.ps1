$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'musescore'
  fileType               = 'msi'
  url                    = 'http://ftp.osuosl.org/pub/musescore/releases/MuseScore-2.2.1/MuseScore-2.2.1.msi'
  url64bit               = 'http://ftp.osuosl.org/pub/musescore/releases/MuseScore-2.2.1/MuseScore-2.2.1.msi'
  checksum               = '38d21b14615404a31650b30c6d2f24e8ba7dd48758b2ed02a52acb8ccc079e3e'
  checksum64             = '38d21b14615404a31650b30c6d2f24e8ba7dd48758b2ed02a52acb8ccc079e3e'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'musescore*'
}
Install-ChocolateyPackage @packageArgs
