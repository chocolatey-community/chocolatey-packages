#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.6.8/prey-windows-1.6.8-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.6.8/prey-windows-1.6.8-x64.msi'
  checksum               = '35f068e0a756dd4d4fda035c3ab35858845e55314ac284e9e886e3abd47fa2a1'
  checksum64             = '52ab70e2ef8a4ef43925a689febca3e46bfc0eb5b60de243e01f590544df0b66'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs
