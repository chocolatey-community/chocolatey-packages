#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.6.4/prey-windows-1.6.4-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.6.4/prey-windows-1.6.4-x64.msi'
  checksum               = '6836ce8c75bd4b5d923e5bfaf5f0169031572240d5287eb137f59d94fb64edd0'
  checksum64             = '3bfb8410a06980a99e7f2935ca9b4586c5457507ff448f1695507f68cfb6ce1f'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs
