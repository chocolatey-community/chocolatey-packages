$ErrorActionPreference = 'Stop'

$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'clipgrab'
  fileType               = 'exe'
  url                    = 'https://download.clipgrab.org/clipgrab-3.6.1.exe'
  checksum               = 'bafeffa79e300853c8629b0d2248144c148e8ce1fc09a04e7198538dbfbc3953'
  checksumType           = 'sha256'
  silentArgs             = '/VERYSILENT'
  validExitCodes         = @(0)
  softwareName           = 'clipgrab*'
}
Install-ChocolateyPackage @packageArgs
