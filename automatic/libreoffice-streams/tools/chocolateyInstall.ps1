$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/6.1.4/win/x86/LibreOffice_6.1.4_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/6.1.4/win/x86_64/LibreOffice_6.1.4_Win_x64.msi'
  checksum               = 'd419309fbc82f4d0b85acb1d2cf46afbe80e037e671c97383626cf509040738a'
  checksum64             = 'ce7d6e3e450d9c0eff1ab04936b5e4cefe5b201371926085de66ecf5a887db3e'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart /l*v "{0}\install.log"' -f "$Env:TEMP\chocolatey\$Env:ChocolateyPackageName\$Env:ChocolateyPackageVersion"
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
