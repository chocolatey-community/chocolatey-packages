$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'musescore'
  fileType               = 'msi'
  url                    = 'http://ftp.osuosl.org/pub/musescore/releases/MuseScore-2.0.3/MuseScore-2.0.3.msi'
  url64bit               = 'http://ftp.osuosl.org/pub/musescore/releases/MuseScore-2.0.3/MuseScore-2.0.3.msi'
  checksum               = 'f45f90adcf4d70bb4e5525b188cd6e65e6a19ebe2d273752068c71a4939633d8'
  checksum64             = 'f45f90adcf4d70bb4e5525b188cd6e65e6a19ebe2d273752068c71a4939633d8'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'musescore*'
}
Install-ChocolateyPackage @packageArgs
