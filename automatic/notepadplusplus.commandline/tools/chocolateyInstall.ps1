$ErrorActionPreference = 'Stop'

$packageName = 'notepadplusplus.commandline'
$url32       = 'https://notepad-plus-plus.org/repository/7.x/7.5/npp.7.5.bin.7z'
$url64       = 'https://notepad-plus-plus.org/repository/7.x/7.5/npp.7.5.bin.x64.7z'
$checksum32  = 'fa8dd184dd807b4d35dac7d3f9c60380a191410283949e336189f9797033cae6'
$checksum64  = '6328b0f27b47edac7d1a3a2d46a2a69ed0dc4c7338252b99bfc2ca2502c81189'
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
