$ErrorActionPreference = 'Stop'

$packageName = 'notepadplusplus.commandline'
$url32       = 'https://notepad-plus-plus.org/repository/7.x/7.4/npp.7.4.bin.7z'
$url64       = 'https://notepad-plus-plus.org/repository/7.x/7.4/npp.7.4.bin.x64.7z'
$checksum32  = '9ce450ffdf8b2691e16da4a185292a51eb1f68dc0e6869b8e281e4baa6175342'
$checksum64  = '7d029aa73e6141efb1af1d269316186b001cf842327a1e27f31008d8bb24bb8c'
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
