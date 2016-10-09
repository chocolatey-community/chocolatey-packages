$ErrorActionPreference = 'Stop'

$packageName = 'notepadplusplus.commandline'
$url32       = ''
$url64       = ''
$checksum32  = ''
$checksum64  = ''
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
