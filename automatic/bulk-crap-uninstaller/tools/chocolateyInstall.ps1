$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'bulk-crap-uninstaller'
  fileType               = 'exe'
  url                    = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.13/BCUninstaller_3.13_setup.exe'
  url64bit               = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.13/BCUninstaller_3.13_setup.exe'
  checksum               = '88058a9102ef9340e4a0b7439bd5d268c0053efda46edca046cdbeff525b9ab2'
  checksum64             = '88058a9102ef9340e4a0b7439bd5d268c0053efda46edca046cdbeff525b9ab2'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  softwareName           = 'Bulk Crap Uninstaller'
}
Install-ChocolateyPackage @packageArgs
