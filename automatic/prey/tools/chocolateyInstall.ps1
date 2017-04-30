#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.6.6/prey-windows-1.6.6-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.6.6/prey-windows-1.6.6-x64.msi'
  checksum               = 'b38c383da6cfc283d9e59ab22629688f82cc4007f166563084a18680cfc450d3'
  checksum64             = '49cbdd7dc73c3a675d1f0c6615db4a7e2809475120109ffda4f27465b4871843'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs
