$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'MSI'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/5.3.5/win/x86/LibreOffice_5.3.5_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/5.3.5/win/x86_64/LibreOffice_5.3.5_Win_x64.msi'
  checksum               = '9fa0aff31851067d241a43f5c5646b746c560f534be40d43bed5e99fc8734961'
  checksum64             = '64ee8bfa7445ed94250808e4c0b1148462498cf52e21786683bbfe3fcd2a4549'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
