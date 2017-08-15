#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.7.0/prey-windows-1.7.0-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.7.0/prey-windows-1.7.0-x64.msi'
  checksum               = '309b4312d65e4125cc9f89a24bdec5d3a4de465a9e7208cbd6d1eac35c2badcc'
  checksum64             = '63f35f41e9232f6a11e9c8002c8c7c13470f2f9b364890788b9093154843a112'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs
