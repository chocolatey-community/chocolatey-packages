$ErrorActionPreference = 'Stop'

$packageName = 'notepadplusplus.commandline'
$url32       = 'https://notepad-plus-plus.org/repository/7.x/7.0/npp.7.bin.7z'
$url64       = 'https://notepad-plus-plus.org/repository/7.x/7.0/npp.7.bin.x64.7z'
$checksum32  = 'a470d40d24d33106b4e12982758174e5037f7fbbdbe0f951d574c9490b45c874'
$checksum64  = '308c26e4bf8b5b572002e8f5daea1157fda590dea158c7790f28b592fe42da64'
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
