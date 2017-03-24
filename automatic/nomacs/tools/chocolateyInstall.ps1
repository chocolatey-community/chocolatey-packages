$ErrorActionPreference = 'Stop'

$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'nomacs'
  fileType               = 'exe'
  url                    = 'http://download.nomacs.org/nomacs-setup.exe'
  url64bit               = 'http://download.nomacs.org/nomacs-setup.exe'
  checksum               = 'd3d13450ddff8d368d844e1232f3df23858201cf795fbd742d2e3699cafdf1be'
  checksum64             = 'd3d13450ddff8d368d844e1232f3df23858201cf795fbd742d2e3699cafdf1be'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '--script "{0}\install-script.js"' -f $toolsPath
  validExitCodes         = @(0)
  softwareName           = 'nomacs*'
}
Install-ChocolateyPackage @packageArgs
