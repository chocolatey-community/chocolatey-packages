$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/6.2.2/win/x86/LibreOffice_6.2.2_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/6.2.2/win/x86_64/LibreOffice_6.2.2_Win_x64.msi'
  checksum               = '87c911ce011c451c46ef5733c904ade8d38a35b8361e7e25b19edd631b83fba1'
  checksum64             = 'ebed6400076d75a4886d4d55cb53012f066c59625f6edd5f8b162aecb51c718c'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart /l*v "{0}\install.log"' -f "$Env:TEMP\chocolatey\$Env:ChocolateyPackageName\$Env:ChocolateyPackageVersion"
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
