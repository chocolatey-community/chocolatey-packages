$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'MSI'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/5.2.6/win/x86/LibreOffice_5.2.6_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/5.2.6/win/x86_64/LibreOffice_5.2.6_Win_x64.msi'
  checksum               = 'f49fd5b36e2c35503389550aabf209d1f1baa09e0e3bb80167052a77bdc5b6b5'
  checksum64             = '57592e0ff1fc77e1ada32146f30d853666a948c9262f9a34f8f7bc8f4204185d'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
