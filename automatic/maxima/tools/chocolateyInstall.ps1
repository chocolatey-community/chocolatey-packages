$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.45.1-Windows/maxima-5.45.1s-win32.exe/download'
  url64bit       = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.45.1-Windows/maxima-5.45.1s-win64.exe/download'
  softwareName   = 'maxima*'
  checksum       = 'fe385011593da096be0929426fe93e0ccd32f4fc4a7bf8c3f0bbdae78d73317b'
  checksumType   = 'sha256'
  checksum64     = '60be72a45376e1256a554d79e7da35f7d91cfc86b12b9a9a5501c0f5ed8b6de0'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
