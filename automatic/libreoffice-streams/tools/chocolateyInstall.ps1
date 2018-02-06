$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/6.0.0/win/x86/LibreOffice_6.0.0_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/6.0.0/win/x86_64/LibreOffice_6.0.0_Win_x64.msi'
  checksum               = 'b2f18f1ce2ace2365f114c687bb2a4db646d8601e849fffb57e19c2874306bb0'
  checksum64             = '6b4b14862d43c5df51034df888e1bfdfc03c391717de32e1a0fb8377b4bb0ced'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
