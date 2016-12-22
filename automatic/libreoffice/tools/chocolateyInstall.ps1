$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/5.2.4/win/x86/LibreOffice_5.2.4_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/5.2.4/win/x86_64/LibreOffice_5.2.4_Win_x64.msi'
  checksum               = 'c04d943c371d9b1d4a060a07689d7383d941186c5df83df75ccb98be572a55a6'
  checksum64             = '21ecb76910cf881c458bfea7846f9d1a624de2341d3128e51bc02cdaa747b7aa'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
