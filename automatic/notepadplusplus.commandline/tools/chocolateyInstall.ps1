$ErrorActionPreference = 'Stop'

$packageName = 'notepadplusplus.commandline'
$url32       = 'https://notepad-plus-plus.org/repository/7.x/7.2.2/npp.7.2.2.bin.7z'
$url64       = 'https://notepad-plus-plus.org/repository/7.x/7.2.2/npp.7.2.2.bin.x64.7z'
$checksum32  = '47eb0e08841b66b1295e3407e5a68f5620542eaf71f10e5a5b506c864c260e5c'
$checksum64  = '3dc95a39c99de1b5b9ad2349d7d9b736a41d4ee0eb6d2eb74247420a0b2b92b9'
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
