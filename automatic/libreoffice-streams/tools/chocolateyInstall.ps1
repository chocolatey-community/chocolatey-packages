$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/6.2.4/win/x86/LibreOffice_6.2.4_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/6.2.4/win/x86_64/LibreOffice_6.2.4_Win_x64.msi'
  checksum               = '7821443630c07ada6b2e901167ebf4c970811ef4c7919e4f2c22946181695a7f'
  checksum64             = '45d3dace90f0572a26bfd22c870cc25eb5665c52f0c148f36c07a17638a4c7d0'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart /l*v "{0}\install.log"' -f "$Env:TEMP\chocolatey\$Env:ChocolateyPackageName\$Env:ChocolateyPackageVersion"
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
