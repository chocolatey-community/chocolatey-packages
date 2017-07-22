$ErrorActionPreference = 'Stop'

$packageName = 'brackets'
$url32       = 'https://github.com/adobe/brackets/releases/download/release-1.10/Brackets.Release.1.10.msi'
$url64       = $url32
$checksum32  = '0ac206ddb6e780e484b30704f44dfb7ed0be7965e62108924d2ce60d641c4cdf'
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
