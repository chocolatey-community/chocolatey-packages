$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'bulk-crap-uninstaller'
  fileType               = 'exe'
  url                    = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.14/BCUninstaller_3.14_setup.exe'
  url64bit               = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.14/BCUninstaller_3.14_setup.exe'
  checksum               = '21e8b25613b98f4680aa663cfed14db4095f71f13f2ff4a2114ef2304d95d593'
  checksum64             = '21e8b25613b98f4680aa663cfed14db4095f71f13f2ff4a2114ef2304d95d593'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  softwareName           = 'Bulk Crap Uninstaller'
}
Install-ChocolateyPackage @packageArgs
