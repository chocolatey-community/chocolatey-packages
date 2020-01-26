$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.43.1-Windows/maxima-clisp-sbcl-5.43.1-win32.exe/download'
  url64bit       = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.43.1-Windows/maxima-clisp-sbcl-5.43.1-win64.exe/download'
  softwareName   = 'maxima*'
  checksum       = '502fc6f8211e483efe093bdf096d00b9e48a853b5e8a44c671840ba246a39231'
  checksumType   = 'sha256'
  checksum64     = '122b6f7e7ba663cd31e7d5697c2b79cea1969ab169e5979edba273f00b0d218a'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
