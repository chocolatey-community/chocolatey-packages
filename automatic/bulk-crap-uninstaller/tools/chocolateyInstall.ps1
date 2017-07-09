$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'bulk-crap-uninstaller'
  fileType               = 'exe'
  url                    = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.11/BCUninstaller_3.11_setup.exe'
  url64bit               = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.11/BCUninstaller_3.11_setup.exe'
  checksum               = '181a2012019c60e7c1a8cc8f61f84d6dffc3c28756df34c485968eeab8c89661'
  checksum64             = '181a2012019c60e7c1a8cc8f61f84d6dffc3c28756df34c485968eeab8c89661'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  softwareName           = 'Bulk Crap Uninstaller'
}
Install-ChocolateyPackage @packageArgs
