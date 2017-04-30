$ErrorActionPreference = 'Stop'

$packageName = 'brackets'
$url32       = 'https://github.com/adobe/brackets/releases/download/release-1.9/Brackets.Release.1.9.msi'
$url64       = $url32
$checksum32  = '46779c5819f9d7b9339eba50e6e34bfa0733ebb6bff9ac88acd5fb913e36ff03'
$checksum64  = $checsum32

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'MSI'
  url                    = $url32
  url64bit               = $url64
  checksum               = $checksum32
  checksum64             = $checksum64
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/q /norestart'
  validExitCodes         = @(0)
  registryUninstallerKey = $packageName
}
Install-ChocolateyPackage @packageArgs
