$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/5.4.7/win/x86/LibreOffice_5.4.7_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/5.4.7/win/x86_64/LibreOffice_5.4.7_Win_x64.msi'
  checksum               = 'e13a0f266dbe1fe9763d0530e1ea0723df03a3f9b3d8974224066ca572b3e02b'
  checksum64             = '25ac7a7bf942430524249bbd5990e84ce8555d1e53294f1e49f487d4f1e5a642'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
