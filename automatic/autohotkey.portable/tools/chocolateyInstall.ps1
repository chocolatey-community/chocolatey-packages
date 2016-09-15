$ErrorActionPreference = 'Stop'

$packageName = 'autohotkey.portable'
$url32       = 'http://ahkscript.org/download/1.1/AutoHotkey112401.zip'
$url64       = 'http://ahkscript.org/download/1.1/AutoHotkey112401_x64.zip'
$checksum32  = '90ECF74C0BDDD243D21B57DB3864EFC3C959CDA7D64296B0A29AD4AC9847E46A'
$checksum64  = '6E61A6CBBADBB37A114C90E885996DE3A392D6E79AF9D9DF37ACF2DCAA8E39E4'
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
