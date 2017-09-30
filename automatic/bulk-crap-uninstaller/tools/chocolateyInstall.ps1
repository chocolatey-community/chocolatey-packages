$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'bulk-crap-uninstaller'
  fileType               = 'exe'
  url                    = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.17/BCUninstaller_3.17_setup.exe'
  url64bit               = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.17/BCUninstaller_3.17_setup.exe'
  checksum               = '589737f7b5e70558c8e9a13aeab0e654a8c73c4d35ec1d620371665e89b6433d'
  checksum64             = '589737f7b5e70558c8e9a13aeab0e654a8c73c4d35ec1d620371665e89b6433d'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  softwareName           = 'Bulk Crap Uninstaller'
}
Install-ChocolateyPackage @packageArgs
