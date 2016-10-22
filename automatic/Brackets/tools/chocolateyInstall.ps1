$ErrorActionPreference = 'Stop'

$packageName = 'brackets'
$url32       = 'https://github.com/adobe/brackets/releases/download/release-1.7/Brackets.Release.1.7.msi'
$url64       = $url32
$checksum32  = 'f5c8d66eba8cdb67c607aa818ec93a7a0a578764782fc7b414ce91a1764b4aff'
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
