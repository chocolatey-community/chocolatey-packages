$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.45.1-Windows/maxima-5.45.1-win32.exe/download'
  url64bit       = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.45.1-Windows/maxima-5.45.1-win64.exe/download'
  softwareName   = 'maxima*'
  checksum       = 'b2ab4d399ec7ecde4ff6bfb0f64f51bfdf52305733a834fe3d5b591922330714'
  checksumType   = 'sha256'
  checksum64     = '245611bdc5c43267ac444a377d40663962265e94db0c59c4831d84d05ddfeadc'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
