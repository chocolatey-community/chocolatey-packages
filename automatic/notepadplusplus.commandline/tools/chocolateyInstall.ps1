$ErrorActionPreference = 'Stop'

$packageName = 'notepadplusplus.commandline'
$url32       = 'https://notepad-plus-plus.org/repository/7.x/7.4.2/npp.7.4.2.bin.7z'
$url64       = 'https://notepad-plus-plus.org/repository/7.x/7.4.2/npp.7.4.2.bin.x64.7z'
$checksum32  = '53c3780fb4079dca1ea90cc0eab2b533cca279d34d31a96c79d7acb6747ed533'
$checksum64  = '4a4b869930e5fa3b143aa9c185aaf50ece0387344e5929bb7181c7d1aceffc7a'
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
