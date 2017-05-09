#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.6.7/prey-windows-1.6.7-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.6.7/prey-windows-1.6.7-x64.msi'
  checksum               = 'e243cc0ab859224a7151247c1c511d93e3240baf9f5875c7f8acde5c5ccf8a37'
  checksum64             = 'd120f9520730cdfd33c20ad35253a29d67fa1cf36d26a50006243560a5eb049f'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs
