$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.44.0-Windows/maxima-clisp-sbcl-5.44.0-win32.exe/download'
  url64bit       = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.44.0-Windows/maxima-clisp-sbcl-5.44.0-win64.exe/download'
  softwareName   = 'maxima*'
  checksum       = 'f0d9cbb8b639d75f1972cdab070fe8670a5375c7110e0c3a89f9d1f426653c93'
  checksumType   = 'sha256'
  checksum64     = '14fca2a76d0307f8f5955cd43defe975fa55abd13a9aa32e854bf1b51c7d8af1'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
