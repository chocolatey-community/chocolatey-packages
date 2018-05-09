$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/6.0.4/win/x86/LibreOffice_6.0.4_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/6.0.4/win/x86_64/LibreOffice_6.0.4_Win_x64.msi'
  checksum               = '05d31998f64b0abe7364307c5949b4ed821c12d890e86396fc9b1c4214e7d999'
  checksum64             = '80d796f1875942e31f00d5983bdba5bc913174cf3fcae6d39cde42148133ddf9'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
