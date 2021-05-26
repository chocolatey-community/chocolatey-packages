$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.45.0-Windows/maxima-5.45.0-win32.exe/download'
  url64bit       = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.45.0-Windows/maxima-5.45.0-win64.exe/download'
  softwareName   = 'maxima*'
  checksum       = '394ae838a1e35e9e7e86b7bedf786e89790834cb9fed14d64c0e537db0dda637'
  checksumType   = 'sha256'
  checksum64     = '068c2c6628fcf6479a686b97a3c0c6a010b0e821b987cf1ad88438c6b5a78e02'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
