$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'bulk-crap-uninstaller'
  fileType               = 'exe'
  url                    = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.6.1/BCUninstaller_3.6.1_setup.exe'
  url64bit               = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.6.1/BCUninstaller_3.6.1_setup.exe'
  checksum               = '07878962b3b8afca029f4e1176652d1cba8264ae133f3caeba91b753ef43b328'
  checksum64             = '07878962b3b8afca029f4e1176652d1cba8264ae133f3caeba91b753ef43b328'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  softwareName           = 'Bulk Crap Uninstaller'
}
Install-ChocolateyPackage @packageArgs
