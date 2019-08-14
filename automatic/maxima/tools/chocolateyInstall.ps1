$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.43.0-Windows/maxima-clisp-sbcl-5.43.0-win32.exe/download'
  url64bit       = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.43.0-Windows/maxima-clisp-sbcl-5.43.0-win64.exe/download'
  softwareName   = 'maxima*'
  checksum       = '15e4f8ed26b763647c3870bac0cb371869764ee30878fd1767505dd30d54012f'
  checksumType   = 'sha256'
  checksum64     = '52cb2fe1218287a5381d71a14ac1466661748267f1c3bd959ff7c50df47f05fd'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
