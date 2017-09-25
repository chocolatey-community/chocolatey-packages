$ErrorActionPreference = 'Stop'

$packageName = 'brackets'
$url32       = 'https://github.com/adobe/brackets/releases/download/release-1.11/Brackets.Release.1.11.msi'
$url64       = $url32
$checksum32  = 'f2a6f51ad5db0801d7cf418e8dd3da5898b737986a6bb9b80308cb882a68e0ec'
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
