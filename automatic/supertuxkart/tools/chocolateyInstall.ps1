$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'supertuxkart'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/supertuxkart/files/SuperTuxKart/0.9.3/supertuxkart-0.9.3-win32.exe/download'
  url64          = 'https://sourceforge.net/projects/supertuxkart/files/SuperTuxKart/0.9.3/supertuxkart-0.9.3-win64.exe/download'
  checksum       = 'e560b3e62d0b4e8fab7639be72f058383c80adcd8ed0a11e9516f0c888876f6e'
  checksum64     = '73978600ee03042eaaecae126f1ecd2239588340f0ce4325564364b4342e9dcf'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'supertuxkart*'
}
Install-ChocolateyPackage @packageArgs
