$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-27.8.3.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-27.8.3.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'c97838cfe49850775d8c0b3ffe7d51f351c018c6a927785bb62beac5b268c083'
  checksumType  = 'sha256'
  checksum64    = '9e06fab26f882322833b4b250acc14d17056004b6c48efc3a60e52a0f35d3dff'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
