$ErrorActionPreference = 'Stop'

$packageName = 'notepadplusplus.commandline'
$url32       = 'https://notepad-plus-plus.org/repository/7.x/7.4.1/npp.7.4.1.bin.7z'
$url64       = 'https://notepad-plus-plus.org/repository/7.x/7.4.1/npp.7.4.1.bin.x64.7z'
$checksum32  = 'a8ae4e4347eb70c31fb8216bdd347a418d0845c971741cf5cf7b9937061571a8'
$checksum64  = 'b81b492cdd05d8e99096d098b99553927bca38d9e3a9b392efb58961a7561aa3'
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
