$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/6.1.0/win/x86/LibreOffice_6.1.0_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/6.1.0/win/x86_64/LibreOffice_6.1.0_Win_x64.msi'
  checksum               = 'dd4524ed7416a3d8533d66a289a9db3f3a4d6231fc8887b2fb50f3ff49a8dff0'
  checksum64             = '17d01f5e9b9944c5888ff41ac7d0c7d8aa93e84c5b5df98183b0b287a2e7c77d'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
