$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'glmixer'
  fileType               = 'exe'
  url                    = 'https://sourceforge.net/projects/glmixer/files/Windows%20Binary/GLMixer_1.5-1329_Windows.exe'
  url64bit               = 'https://sourceforge.net/projects/glmixer/files/Windows%20Binary/GLMixer_1.5-1329_Windows.exe'
  checksum               = ''
  checksum64             = 'cfdad745f98390c5c0b40976ef25dd9899811bcd610f69471eb9533c756f1649'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'Graphic Live Mixer'
}

Write-Host "Warning: This package only supports 64 bit architecture." -ForegroundColor "White"

Install-ChocolateyPackage @packageArgs
