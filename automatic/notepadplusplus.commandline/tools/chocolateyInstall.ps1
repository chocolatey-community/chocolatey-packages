$ErrorActionPreference = 'Stop'

$packageName = 'notepadplusplus.commandline'
$url32       = 'https://notepad-plus-plus.org/repository/7.x/7.3.3/npp.7.3.3.bin.7z'
$url64       = 'https://notepad-plus-plus.org/repository/7.x/7.3.3/npp.7.3.3.bin.x64.7z'
$checksum32  = '672eb5f7cc36f2e5b98f8ca906141b3abac2f131736d704c93f3cc4469f29c4f'
$checksum64  = 'f54c62ce4f8de6a7cd008489e7440b9fc3f2e81eb186b17e4d603177cd20865e'
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
