$ErrorActionPreference = 'Stop'

$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'nomacs'
  fileType               = 'exe'
  url                    = 'http://download.nomacs.org/nomacs-setup.exe'
  url64bit               = 'http://download.nomacs.org/nomacs-setup.exe'
  checksum               = '580702af8d677d0172812f9c906e25686b2a0fd057a7e05ca6fbafbefa797967'
  checksum64             = '580702af8d677d0172812f9c906e25686b2a0fd057a7e05ca6fbafbefa797967'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '--script "{0}\install-script.js"' -f $toolsPath
  validExitCodes         = @(0)
  softwareName           = 'nomacs*'
}
Install-ChocolateyPackage @packageArgs
