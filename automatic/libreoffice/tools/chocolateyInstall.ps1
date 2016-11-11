$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/5.2.3/win/x86/LibreOffice_5.2.3_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/5.2.3/win/x86_64/LibreOffice_5.2.3_Win_x64.msi'
  checksum               = '521a85c28ddc7ec69cbfb1c1d42f21f73eb72948710e63fb6b1cf3508b1092e2'
  checksum64             = 'adec6a46296b90c86b72ec8f59fb0e6dc38c787d72fb92290ca529fd59cf7300'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
