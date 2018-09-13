$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/6.1.1/win/x86/LibreOffice_6.1.1_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/6.1.1/win/x86_64/LibreOffice_6.1.1_Win_x64.msi'
  checksum               = 'a35240ae3e7d7310d943389cab0acebf4cb91b20f4ac9cf3ce9342cea7a1144b'
  checksum64             = '05b7cd7d55dc5feb2f5da401c3676f0c091ad7db820424cca2aff77f8a300cb5'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart /l*v "{0}\install.log"' -f "$Env:TEMP\chocolatey\$Env:ChocolateyPackageName\$Env:ChocolateyPackageVersion"
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
