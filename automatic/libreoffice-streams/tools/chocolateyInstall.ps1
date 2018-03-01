$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/6.0.2/win/x86/LibreOffice_6.0.2_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/6.0.2/win/x86_64/LibreOffice_6.0.2_Win_x64.msi'
  checksum               = '8e197eda7e22f3d766caa82d7c1738a9ab8d398481e43faa8ae001f3c466ef5c'
  checksum64             = '14c91fd4251648637f5bf1ad62c34f271d400eadc7cd989753d43b7e40fe27c2'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
