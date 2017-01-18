$ErrorActionPreference = 'Stop'

$packageName = 'notepadplusplus.commandline'
$url32       = 'https://notepad-plus-plus.org/repository/7.x/7.3.1/npp.7.3.1.bin.7z'
$url64       = 'https://notepad-plus-plus.org/repository/7.x/7.3.1/npp.7.3.1.bin.x64.7z'
$checksum32  = 'bdbf81074293695b2cc78824d68d0a1b0a2d896df59dfd315b59b8c1c3c58d9b'
$checksum64  = '7e4fabc87d8ba1d3f26266515367cdf4a20780336e416d35ccbe46d8f6f1d37a'
$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $packageName
  url            = $url32
  url64Bit       = $url64
  checksum       = $checksum32
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  unzipLocation  = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs
