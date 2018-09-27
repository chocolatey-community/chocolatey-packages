$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/6.1.2/win/x86/LibreOffice_6.1.2_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/6.1.2/win/x86_64/LibreOffice_6.1.2_Win_x64.msi'
  checksum               = 'ecd8678310e6dd2d73bd577f51d161c9f525865bd4b1dfc11fee66c76c3b636a'
  checksum64             = 'ddd4cf674cc2543f7d5f375562853386793fc6003fe70fa270baf905af7f00fe'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart /l*v "{0}\install.log"' -f "$Env:TEMP\chocolatey\$Env:ChocolateyPackageName\$Env:ChocolateyPackageVersion"
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
