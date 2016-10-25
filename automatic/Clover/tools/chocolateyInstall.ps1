$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'clover'
  fileType               = 'EXE'
  url                    = 'http://ejie.me/uploads/setup_clover@3.2.0.exe'
  checksum               = '78a60d2321d8da2837ee5c3f50893ad4da2686dbcfb5ca6a1cc4f046f2dadcd3'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = ''
}
Install-ChocolateyPackage @packageArgs
