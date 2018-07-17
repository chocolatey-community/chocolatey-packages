#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.8.0/prey-windows-1.8.0-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.8.0/prey-windows-1.8.0-x64.msi'
  checksum               = '414d58fbaf466b356123bb44b78881ecd75d66d0de40c24413b788768ac67841'
  checksum64             = 'e4f667a0ceeae014229c7137cad3c55919ce051c81666b532b90f65677d50731'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs
