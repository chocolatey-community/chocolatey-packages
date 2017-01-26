$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/5.2.5/win/x86/LibreOffice_5.2.5_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/5.2.5/win/x86_64/LibreOffice_5.2.5_Win_x64.msi'
  checksum               = '1f25bd3a3b521e18a68f520fd138277c533067ea21dab21401c6fc472c8fb2bf'
  checksum64             = 'bd6206c66f81de7ea628d6126a2a50bcefa4a856e59bd3d3c47c92eb07a8fda0'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
