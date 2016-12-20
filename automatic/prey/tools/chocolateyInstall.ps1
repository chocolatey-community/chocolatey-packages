#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.6.5/prey-windows-1.6.5-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.6.5/prey-windows-1.6.5-x64.msi'
  checksum               = '82443710115d033c7f6d7eaf8426a980ae531cbf63cb958dee40bb6f127a7722'
  checksum64             = 'f91d125da6e71bb49a15f9b0fec00227fc19df6467d10ef36f6ac6d66be14778'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs
