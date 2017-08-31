$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/5.4.1/win/x86/LibreOffice_5.4.1_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/5.4.1/win/x86_64/LibreOffice_5.4.1_Win_x64.msi'
  checksum               = '9cc38ae442906b4b73fcb65d3656312e70fb773f0451c38ee5efb10407f84fee'
  checksum64             = 'd5580124e1a856dbc25954e0786f00ac3696384ad69429f611dcfd32afa52014'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
