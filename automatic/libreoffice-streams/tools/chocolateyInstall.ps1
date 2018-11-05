$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/6.1.3/win/x86/LibreOffice_6.1.3_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/6.1.3/win/x86_64/LibreOffice_6.1.3_Win_x64.msi'
  checksum               = '389fb5bc70d78c9039d70fa1bc8b21f7db590bd67231cc34987c08179d021526'
  checksum64             = 'c3d2587a247b5c873286f80fdf0eef4b055808899e11e4f1c80874709b8df819'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart /l*v "{0}\install.log"' -f "$Env:TEMP\chocolatey\$Env:ChocolateyPackageName\$Env:ChocolateyPackageVersion"
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
