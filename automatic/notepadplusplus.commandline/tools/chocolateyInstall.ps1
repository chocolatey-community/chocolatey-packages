$ErrorActionPreference = 'Stop'

$packageName = 'notepadplusplus.commandline'
$url32       = 'https://notepad-plus-plus.org/repository/7.x/7.5.1/npp.7.5.1.bin.7z'
$url64       = 'https://notepad-plus-plus.org/repository/7.x/7.5.1/npp.7.5.1.bin.x64.7z'
$checksum32  = '899972b2e8f2aff5a8355d445241a8b5a4d7a83f582c8dcd7705cb498f58880e'
$checksum64  = '6ed4756967d679001c8466f2440f9c6dbd75e6474823b5a6cae084ba3431a583'
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
