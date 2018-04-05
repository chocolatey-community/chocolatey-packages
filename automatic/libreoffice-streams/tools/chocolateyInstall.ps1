$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/6.0.3/win/x86/LibreOffice_6.0.3_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/6.0.3/win/x86_64/LibreOffice_6.0.3_Win_x64.msi'
  checksum               = '0adfd0d03504c90b2d04b3c0e208cef8c76c75931603bec611914d3a97062647'
  checksum64             = '25347d1113456a1d49bd8114c65b8a8e58a64c7d77c9b7ca2ae0bd18f16e0c8a'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
