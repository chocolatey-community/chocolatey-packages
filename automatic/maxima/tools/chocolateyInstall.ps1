$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.48.1-Windows/maxima-5.48.1-win32.exe/download'
  url64bit       = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.48.1-Windows/maxima-5.48.1-win64.exe/download'
  softwareName   = 'maxima*'
  checksum       = '1ee14d7d555f7b5952a931d1e0d927cca550aacd9aeed20cba81f871c8545714'
  checksumType   = 'sha256'
  checksum64     = '72fdb3606520180514d5c9fce26dd0165e7dc61703bf2746d667e5d1de495cb7'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
