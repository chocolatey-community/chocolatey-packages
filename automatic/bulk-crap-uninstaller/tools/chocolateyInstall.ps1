$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'bulk-crap-uninstaller'
  fileType               = 'exe'
  url                    = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.10/BCUninstaller_3.10_setup.exe'
  url64bit               = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.10/BCUninstaller_3.10_setup.exe'
  checksum               = '7e287924c5002a5dd6cb8b34477bbdfd5054f7cec4897c32c3f7e45aeec89fd3'
  checksum64             = '7e287924c5002a5dd6cb8b34477bbdfd5054f7cec4897c32c3f7e45aeec89fd3'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  softwareName           = 'Bulk Crap Uninstaller'
}
Install-ChocolateyPackage @packageArgs
