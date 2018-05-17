#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.7.5/prey-windows-1.7.5-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.7.5/prey-windows-1.7.5-x64.msi'
  checksum               = 'eecc0ae67afdd943d7429309b7a35e1d2847b506d9ef1cf4de17ca4f83d79de0'
  checksum64             = 'a3f0ea7440ed05304ad3ec1c422f32fac90d87e6d31a025d2318040109ff600d'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs
