$ErrorActionPreference = 'Stop'

$packageName = 'nirmcmd'
$url32       = 'http://www.nirsoft.net/utils/nircmd.zip'
$url64       = 'http://www.nirsoft.net/utils/nircmd-x64.zip'
$checksum32  = 'f56a6166f8956c507cc2bfec71339f3c467c0421fe6d16fbe4c52a36d79ce0ea'
$checksum64  = '37445b39e2fc437688164866c495bd28890ded5d0dbf71615bf92776e57c5189'
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
