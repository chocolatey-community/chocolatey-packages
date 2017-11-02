$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/5.3.7/win/x86/LibreOffice_5.3.7_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/5.3.7/win/x86_64/LibreOffice_5.3.7_Win_x64.msi'
  checksum               = '974a700c7fa77749506658c1e178927b6052d6d9d49dca9048921506cd593261'
  checksum64             = 'f3345825d32f87036c269ee6ec244da0b97bd424ae601aa2ff5f10a43cd4f0f5'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
