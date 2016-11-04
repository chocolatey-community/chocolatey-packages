$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'MSI'
  url                    = 'http://download.documentfoundation.org/libreoffice/stable/5.2.2/win/x86/LibreOffice_5.2.2_Win_x86.msi'
  url64bit               = 'http://download.documentfoundation.org/libreoffice/stable/5.2.2/win/x86_64/LibreOffice_5.2.2_Win_x64.msi'
  checksum               = '97fbe09d2f89d4584af45244b1b5dce256af235729d2dc5684a0095aea3de20c'
  checksum64             = '57879f1acf4cc9d70bef88d353f5afa7691a0b49e43437efdf5497eff9fd3ed2'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
