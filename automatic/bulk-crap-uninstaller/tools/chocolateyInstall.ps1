$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'bulk-crap-uninstaller'
  fileType               = 'exe'
  url                    = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.8.3/BCUninstaller_3.8.3_setup.exe'
  url64bit               = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.8.3/BCUninstaller_3.8.3_setup.exe'
  checksum               = '2289752d00aee15b2fa0fb6a5d96325e9dc9c73eac6281648a95f422ccba79c2'
  checksum64             = '2289752d00aee15b2fa0fb6a5d96325e9dc9c73eac6281648a95f422ccba79c2'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  softwareName           = 'Bulk Crap Uninstaller'
}
Install-ChocolateyPackage @packageArgs
