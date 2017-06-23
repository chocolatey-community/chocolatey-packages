$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'maxima'
  fileType               = 'exe'
  url                    = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.40.0-Windows/maxima-clisp-sbcl-5.40.0-win32.exe'
  url64bit               = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.40.0-Windows/maxima-clisp-sbcl-5.40.0-win64.exe'
  checksum               = '28eab0305f092b195cf81778c676bd7edabd15b0a8713c44b454c9b1c6b5cf0a'
  checksum64             = '3c78b27ef1d3f1ac08c97f84f1a8653e7f38b7fec4a66699015dd094c95cfd2a'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'maxima*'
}
Install-ChocolateyPackage @packageArgs
