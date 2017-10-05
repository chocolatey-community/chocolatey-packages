$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/5.4.2/win/x86/LibreOffice_5.4.2_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/5.4.2/win/x86_64/LibreOffice_5.4.2_Win_x64.msi'
  checksum               = '4796b4a150bbd9b749933b3b60b4e0cd2e55b06a207147ee6b0e88c2ebd8b699'
  checksum64             = '89654954118f46df428eceb892f694f84a58bbfe6179abcfb8728cd244e5ec9b'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
