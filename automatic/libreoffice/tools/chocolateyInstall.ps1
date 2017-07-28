$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/5.4.0/win/x86/LibreOffice_5.4.0_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/5.4.0/win/x86_64/LibreOffice_5.4.0_Win_x64.msi'
  checksum               = '015be18efadf6b001f767b8bfcb9460eb6ce6721566ca65120a383dbecb1be99'
  checksum64             = '87aa62d1bb7e21b624e9cba46b3b51e40807d353b4d483cf1b13ee19e8b6092a'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
