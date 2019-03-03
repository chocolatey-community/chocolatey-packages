$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/6.2.0/win/x86/LibreOffice_6.2.0_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/6.2.0/win/x86_64/LibreOffice_6.2.0_Win_x64.msi'
  checksum               = '71ceed80aa77137cf60264652d435930bdb1d4f0c8ee5d7418885ad6ac795d67'
  checksum64             = '83028ca0db1a87abb304d77524b51d42be734e0e74f22012bdb7f750d8328996'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart /l*v "{0}\install.log"' -f "$Env:TEMP\chocolatey\$Env:ChocolateyPackageName\$Env:ChocolateyPackageVersion"
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
