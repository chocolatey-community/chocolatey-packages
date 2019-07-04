$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/6.2.5/win/x86/LibreOffice_6.2.5_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/6.2.5/win/x86_64/LibreOffice_6.2.5_Win_x64.msi'
  checksum               = '717fb9e17a3feb8af1662e668b919db86fab343303b78f88c7859003056ee010'
  checksum64             = '9b01f6f382dbb31367e12cfb0ad4c684546f00edb20054eeac121e7e036a5389'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart /l*v "{0}\install.log"' -f "$Env:TEMP\chocolatey\$Env:ChocolateyPackageName\$Env:ChocolateyPackageVersion"
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
