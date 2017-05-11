$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/5.3.3/win/x86/LibreOffice_5.3.3_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/5.3.3/win/x86_64/LibreOffice_5.3.3_Win_x64.msi'
  checksum               = 'f57824b10ad2fd871ff8f0bf7edb4d810b4d05fb2189aa7daa953a10184c2512'
  checksum64             = '19e0e570965cc4b0794cb0e5e98af5d81ef09ee8b3e585e5e27cfe2688f6748e'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
