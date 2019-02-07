$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/6.1.5/win/x86/LibreOffice_6.1.5_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/6.1.5/win/x86_64/LibreOffice_6.1.5_Win_x64.msi'
  checksum               = 'bfac8629d6db9e921010330e926bde080fb1f5fbb285fca684ea15b182950b66'
  checksum64             = '812e01eaa790c8fa66c91254e9255ec494f22a92e8d18bfbe50486c842884289'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart /l*v "{0}\install.log"' -f "$Env:TEMP\chocolatey\$Env:ChocolateyPackageName\$Env:ChocolateyPackageVersion"
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
