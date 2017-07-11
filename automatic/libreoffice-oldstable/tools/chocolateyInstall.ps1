$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'MSI'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/5.2.7/win/x86/LibreOffice_5.2.7_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/5.2.7/win/x86_64/LibreOffice_5.2.7_Win_x64.msi'
  checksum               = '6be17ac306440f0dcc430ff06aa5275398f143f7459305575cbfc56470a3a91d'
  checksum64             = 'e64b4d8203d4e034b7c55409cd7ca559ee76e281c8d98b83172615f837741514'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
