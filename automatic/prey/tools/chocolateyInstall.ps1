#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.7.2/prey-windows-1.7.2-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.7.2/prey-windows-1.7.2-x64.msi'
  checksum               = 'e55e6ebd0a0653650dcb41b2f7c1bdc5a5d22a5cc897dc846017f00cccf9dbbb'
  checksum64             = 'b00ef2f19fff5f3530202582e9c7bf828e212071e965dd77592571bcddf52e7c'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs
