$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/6.0.5/win/x86/LibreOffice_6.0.5_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/6.0.5/win/x86_64/LibreOffice_6.0.5_Win_x64.msi'
  checksum               = 'd900ef96634d25dce711f03b2bb877592fe09716380e441e6ee3fc935019cd66'
  checksum64             = '52e2ae72baa2e4251e9de71fcd1b1d8c360729f71a7172fae96dcf9d304cf5b5'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
