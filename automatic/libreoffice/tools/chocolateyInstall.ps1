$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/5.3.2/win/x86/LibreOffice_5.3.2_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/5.3.2/win/x86_64/LibreOffice_5.3.2_Win_x64.msi'
  checksum               = '14644404bce6dcdb4ee8164884e17bc187041aadfc1531971416b9c1c05aa350'
  checksum64             = 'bc361f37185cfa3c3090e7c500f04b001595f74a0f88e4bd159e804a5c2ed706'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
