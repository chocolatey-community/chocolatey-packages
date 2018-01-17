#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.7.3/prey-windows-1.7.3-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.7.3/prey-windows-1.7.3-x64.msi'
  checksum               = '36d7c118a3b4ba9548a1fd6d1a942c22ee7dd5c73672be130a4994ef13a51897'
  checksum64             = '45b3f1c0f3c3404f6b371b4ebd9dd4b74ff46cbc056d8dbabbaea837fa961065'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs
