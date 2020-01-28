$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.43.2-Windows/maxima-clisp-sbcl-5.43.2-win32.exe/download'
  url64bit       = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.43.2-Windows/maxima-clisp-sbcl-5.43.2-win64.exe/download'
  softwareName   = 'maxima*'
  checksum       = 'b7b97f7b3cffc9ab79446dd898d22fccdbedddab38af63627ea3941342d0ca4d'
  checksumType   = 'sha256'
  checksum64     = '75e34f693f5158063e698071eca6555fb8125dfd1f4f1f271a5504a1fc48305c'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
