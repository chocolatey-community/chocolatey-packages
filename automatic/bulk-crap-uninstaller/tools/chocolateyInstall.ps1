$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'bulk-crap-uninstaller'
  fileType               = 'exe'
  url                    = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.7.1/BCUninstaller_3.7.1_setup.exe'
  url64bit               = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.7.1/BCUninstaller_3.7.1_setup.exe'
  checksum               = '9ffbbf4f88dad06d04d6bb4d208fdfd02f8d0e8c60b3ca227798ce30c72c19ee'
  checksum64             = '9ffbbf4f88dad06d04d6bb4d208fdfd02f8d0e8c60b3ca227798ce30c72c19ee'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  softwareName           = 'Bulk Crap Uninstaller'
}
Install-ChocolateyPackage @packageArgs
