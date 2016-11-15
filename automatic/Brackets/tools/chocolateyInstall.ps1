$ErrorActionPreference = 'Stop'

$packageName = 'brackets'
$url32       = 'https://github.com/adobe/brackets/releases/download/release-1.8/Brackets.Release.1.8.msi'
$url64       = $url32
$checksum32  = '93e9cd7fd8899a2401ec2e591c93825664da364a6c0bd600a5298e3e58f06f20'
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
