$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'bulk-crap-uninstaller'
  fileType               = 'exe'
  url                    = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.9/BCUninstaller_3.9_setup.exe'
  url64bit               = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.9/BCUninstaller_3.9_setup.exe'
  checksum               = '02c5888c9efb99038fef066b9fada99599f386ccf3da4343bef9f3b486aca150'
  checksum64             = '02c5888c9efb99038fef066b9fada99599f386ccf3da4343bef9f3b486aca150'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  softwareName           = 'Bulk Crap Uninstaller'
}
Install-ChocolateyPackage @packageArgs
