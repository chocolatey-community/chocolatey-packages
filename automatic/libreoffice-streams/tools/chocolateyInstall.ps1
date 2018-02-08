$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/5.4.5/win/x86/LibreOffice_5.4.5_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/5.4.5/win/x86_64/LibreOffice_5.4.5_Win_x64.msi'
  checksum               = '7d577f9ab89d1e5505b8860a90792d07a3b1f68d876b5cb289f7c8d3a1554063'
  checksum64             = '7eaea44fac935e4ba416ba520e052f7cb21d73dcceb8c1be4bd7386050eb7d68'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
