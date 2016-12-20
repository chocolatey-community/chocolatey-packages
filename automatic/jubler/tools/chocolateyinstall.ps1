$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'jubler'
  fileType      = 'exe'
  url           = 'https://sourceforge.net/projects/jubler/files/Jubler%20Binary%20Releases/5.1/Jubler-5.1_32.exe/download'
  url64         = 'https://sourceforge.net/projects/jubler/files/Jubler%20Binary%20Releases/5.1/Jubler-5.1_64.exe/download'

  softwareName  = 'Jubler subtitle editor'

  checksum      = '22e3c1ea77c44ac86065a8d79c18052b0c7bfcae9d0121c22d53f2b4827e378e'
  checksumType  = 'sha256'
  checksum64    = 'ce1875c4e992bfcc260544c133a2abf600815707bb5ce1338d62576b021d9539'
  checksumType64= 'sha256'

  silentArgs    = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
