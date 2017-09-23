$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'bulk-crap-uninstaller'
  fileType               = 'exe'
  url                    = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.16/BCUninstaller_3.16_setup.exe'
  url64bit               = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.16/BCUninstaller_3.16_setup.exe'
  checksum               = 'b530e4cd5fb747e9bcadee5115d916606f45c004c6ef4f7ed29ccf46805fcbea'
  checksum64             = 'b530e4cd5fb747e9bcadee5115d916606f45c004c6ef4f7ed29ccf46805fcbea'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  softwareName           = 'Bulk Crap Uninstaller'
}
Install-ChocolateyPackage @packageArgs
