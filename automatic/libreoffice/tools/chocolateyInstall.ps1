$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/5.3.4/win/x86/LibreOffice_5.3.4_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/5.3.4/win/x86_64/LibreOffice_5.3.4_Win_x64.msi'
  checksum               = 'd237dbdc7f5df1d606cbd0c792661519b818e8659c4df6b7c4a9e9f01ba6e5c3'
  checksum64             = 'e4ac2a15d4dec1fcd6c1add44b13f359635189f603aa59cb7b893ee4727470ac'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
