$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/6.0.1/win/x86/LibreOffice_6.0.1_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/6.0.1/win/x86_64/LibreOffice_6.0.1_Win_x64.msi'
  checksum               = '02fb4846bd1081e310af1b0f34cd1a3abbd067b44c078d6207761d2a52b36939'
  checksum64             = '61cec581df5a11d5ee1d58b744cfedf2a38dc4833588e88fd2d45da0c2595fa2'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}
Install-ChocolateyPackage @packageArgs
