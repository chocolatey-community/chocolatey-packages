$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'bulk-crap-uninstaller'
  fileType               = 'exe'
  url                    = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.6/BCUninstaller_3.6_setup.exe'
  url64bit               = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.6/BCUninstaller_3.6_setup.exe'
  checksum               = '002e1ce966c4f6401f8387d208ff4d660fbd85cd66c013c8d56d9b80541e6ee1'
  checksum64             = '002e1ce966c4f6401f8387d208ff4d660fbd85cd66c013c8d56d9b80541e6ee1'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  softwareName           = 'Bulk Crap Uninstaller'
}
Install-ChocolateyPackage @packageArgs
