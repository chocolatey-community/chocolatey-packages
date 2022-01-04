$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'supertuxkart'
  fileType       = 'exe'
  url            = 'https://github.com/supertuxkart/stk-code/releases/download/1.3/SuperTuxKart-1.3-installer-i686.exe'
  url64          = 'https://github.com/supertuxkart/stk-code/releases/download/1.3/SuperTuxKart-1.3-installer-x86_64.exe'
  checksum       = '4379102b1e8de7356038a0eef42520202ee043f00a04a399b958d2c3df24825c'
  checksum64     = '262bb2936bcb2acee818b052a0bfb6d437f21ef7e7634d502336c297a9cc0c9e'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'supertuxkart*'
}
Install-ChocolateyPackage @packageArgs
