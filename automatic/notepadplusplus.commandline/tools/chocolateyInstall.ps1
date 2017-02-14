$ErrorActionPreference = 'Stop'

$packageName = 'notepadplusplus.commandline'
$url32       = 'https://notepad-plus-plus.org/repository/7.x/7.3.2/npp.7.3.2.bin.7z'
$url64       = 'https://notepad-plus-plus.org/repository/7.x/7.3.2/npp.7.3.2.bin.x64.7z'
$checksum32  = 'efefd896c49185172235f8a84e051712899b8e929afb7c795cdbdc15eee96b82'
$checksum64  = 'd0c44a6409b383e023a732842652c241fb1e2be5fe5950a7d46eac318594108c'
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
