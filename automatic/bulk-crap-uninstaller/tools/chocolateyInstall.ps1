$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'bulk-crap-uninstaller'
  fileType               = 'exe'
  url                    = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.8.1/BCUninstaller_3.8.1_setup.exe'
  url64bit               = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.8.1/BCUninstaller_3.8.1_setup.exe'
  checksum               = '1625fb6f541186972c5f08b7c59fcb7247dcbc5d4939721119b9814b4d901401'
  checksum64             = '1625fb6f541186972c5f08b7c59fcb7247dcbc5d4939721119b9814b4d901401'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  softwareName           = 'Bulk Crap Uninstaller'
}
Install-ChocolateyPackage @packageArgs
