$ErrorActionPreference = 'Stop'

$url32       = 'https://autohotkey.com/download/1.1/AutoHotkey112401.zip'
$url64       = 'https://autohotkey.com/download/1.1/AutoHotkey112401_x64.zip'
$checksum32  = '90ecf74c0bddd243d21b57db3864efc3c959cda7d64296b0a29ad4ac9847e46a'
$checksum64  = '6e61a6cbbadbb37a114c90e885996de3a392d6e79af9d9df37acf2dcaa8e39e4'

$packageArgs = @{
  packageName    = 'autohotkey.portable'
  url            = $url32
  url64Bit       = $url64
  checksum       = $checksum32
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  unzipLocation  = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
}

Install-ChocolateyZipPackage @packageArgs
