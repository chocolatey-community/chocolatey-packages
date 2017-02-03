$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'bulk-crap-uninstaller'
  fileType               = 'exe'
  url                    = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.7/BCUninstaller_3.7_setup.exe'
  url64bit               = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.7/BCUninstaller_3.7_setup.exe'
  checksum               = '41550e610f3a206e86996b2cc0c35db55e37ef6f6a3fd00d70e57c408fb01d9d'
  checksum64             = '41550e610f3a206e86996b2cc0c35db55e37ef6f6a3fd00d70e57c408fb01d9d'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  softwareName           = 'Bulk Crap Uninstaller'
}
Install-ChocolateyPackage @packageArgs
