$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/6.2.3/win/x86/LibreOffice_6.2.3_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/6.2.3/win/x86_64/LibreOffice_6.2.3_Win_x64.msi'
  checksum               = '9b2b32158d0ff37cc522519a8e9683bcb2b59a58967a8413bd233e83862fae6e'
  checksum64             = '579bc692bffa300d05c77c90bcccfe3afc9681f12f0967c2196bdedb1ac6430e'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart /l*v "{0}\install.log"' -f "$Env:TEMP\chocolatey\$Env:ChocolateyPackageName\$Env:ChocolateyPackageVersion"
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
