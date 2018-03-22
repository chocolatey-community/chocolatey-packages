$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/5.4.6/win/x86/LibreOffice_5.4.6_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/5.4.6/win/x86_64/LibreOffice_5.4.6_Win_x64.msi'
  checksum               = '0d4c26e9894f0ecfd93ec10d69c3fa483afe058ef5c99453a48827464a77ad54'
  checksum64             = 'de37d4b008d462641fc175f0a0c78990da00231912e8f75f88db76535f2ebcb9'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
