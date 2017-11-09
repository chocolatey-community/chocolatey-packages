$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/5.4.3/win/x86/LibreOffice_5.4.3_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/5.4.3/win/x86_64/LibreOffice_5.4.3_Win_x64.msi'
  checksum               = '81de54e88c79a4a2c00fa49b64874a506e6a94a9a54f70a1b1a6b7a7f910b73d'
  checksum64             = '70995d375091c769936f438e51d41b6d92d2a26ff8d04674eb695bbe88dba7c0'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
