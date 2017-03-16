$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/5.3.1/win/x86/LibreOffice_5.3.1_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/5.3.1/win/x86_64/LibreOffice_5.3.1_Win_x64.msi'
  checksum               = 'e258d4b3d5cf6cdc39b3c046d49dc541b4792eecf2d5ec3ef571115beaf73259'
  checksum64             = '1aef6b87956cdb1450ccdaa06b4a363a68a7a3088542eebb003b3e90223aef6c'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
