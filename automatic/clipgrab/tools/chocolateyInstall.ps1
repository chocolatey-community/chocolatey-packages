$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'clipgrab'
  fileType               = 'exe'
  url                    = 'https://download.clipgrab.org/clipgrab-3.6.2-cgde.exe'
  checksum               = 'b50e1e9eb59246a905fca33c1e5412f7ec4a6202e6c7427fce40b9db12668662'
  checksumType           = 'sha256'
  silentArgs             = '/VERYSILENT'
  validExitCodes         = @(0)
  softwareName           = 'clipgrab*'
}
Install-ChocolateyPackage @packageArgs
