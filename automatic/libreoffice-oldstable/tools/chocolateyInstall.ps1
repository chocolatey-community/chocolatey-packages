$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'MSI'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/5.3.6/win/x86/LibreOffice_5.3.6_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/5.3.6/win/x86_64/LibreOffice_5.3.6_Win_x64.msi'
  checksum               = '422e20da0249642381a90c7387d1f3dd843beb50807d8f10f2d8d8c4bda4f7da'
  checksum64             = '8d404592932fc7e407e0c40005bf49124812088efaae288bf69e297830004d00'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
