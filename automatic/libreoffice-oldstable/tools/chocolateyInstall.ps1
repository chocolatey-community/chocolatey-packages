$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'MSI'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/5.1.6/win/x86/LibreOffice_5.1.6_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/5.1.6/win/x86_64/LibreOffice_5.1.6_Win_x64.msi'
  checksum               = '74eda1132918d47e790258fe220221ef1c605efb2c8859050660643560268cb4'
  checksum64             = 'fb186de07db10ce62e14ba708e3d1a8f8c7b72571d48672a507b16982704e4bf'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
