$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/5.3.0/win/x86/LibreOffice_5.3.0_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/5.3.0/win/x86_64/LibreOffice_5.3.0_Win_x64.msi'
  checksum               = '1dd1026627a1f83b095cee9a1ce9444e2e6b137c061123e26df80dd40317ef25'
  checksum64             = '1347fc4edba74a5ca20f35c89d8ad68b57a9d52b23c3c8b2b3737b0ca94c01b4'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
