#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.6.3/prey-windows-1.6.3-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.6.3/prey-windows-1.6.3-x64.msi'
  checksum               = 'e355feda4fb489bf6bce332d5e18962b6feb4222933e5f34520656aa07248240'
  checksum64             = '3e240d2b42237da07c45d312d7f861d1e2d06773d23387e4a2e5b6a5bc006e8b'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs
