$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/6.2.1/win/x86/LibreOffice_6.2.1_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/6.2.1/win/x86_64/LibreOffice_6.2.1_Win_x64.msi'
  checksum               = 'b8475cb2710107e6c796876925983406126f123bf45e4ab377ff499efed69096'
  checksum64             = '2e873945053f7ca2be944de5027982cb76bade585a3056eb0463a0c63159b7f6'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart /l*v "{0}\install.log"' -f "$Env:TEMP\chocolatey\$Env:ChocolateyPackageName\$Env:ChocolateyPackageVersion"
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
