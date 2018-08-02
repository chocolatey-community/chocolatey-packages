$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/6.0.6/win/x86/LibreOffice_6.0.6_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/6.0.6/win/x86_64/LibreOffice_6.0.6_Win_x64.msi'
  checksum               = '8438f42ebb988c66b5e20f64a7067a4e14f229d0df3f9bd0bc5fb4939351d2e5'
  checksum64             = '7a4746ad788d15fb78f3e76bd4f6bfcdf5311f96e31b7969952a764c5adca08f'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
