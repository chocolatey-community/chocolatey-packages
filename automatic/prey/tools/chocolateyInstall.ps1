#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.6.9/prey-windows-1.6.9-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.6.9/prey-windows-1.6.9-x64.msi'
  checksum               = '459a30733c2e8f5d6c3334de2ad704515f1ac10e0b9017364d81ea50f5cd30bf'
  checksum64             = 'f845f85cd5cc6140444672c2bbe42f7e75e8d1ab498fe2e563343734927dcdc4'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs
