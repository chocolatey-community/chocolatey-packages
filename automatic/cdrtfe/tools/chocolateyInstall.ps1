$ErrorActionPreference = 'Stop'

$packageName = 'cdrtfe'
$url32       = 'http://sourceforge.net/projects/cdrtfe/files/cdrtfe/cdrtfe%201.5.6/cdrtfe-1.5.6.exe'
$url64       = $url32
$checksum32  = '5bb668821147bbc2acc7beacf242b25d84f9e3bfb1e7ac44025c204a1ae6cec4'
$checksum64  = $checksum32

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url32
  url64bit               = $url64
  checksum               = $checksum32
  checksum64             = $checksum64
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT'
  validExitCodes         = @(0)
  registryUninstallerKey = $packageName
}
Install-ChocolateyPackage @packageArgs
