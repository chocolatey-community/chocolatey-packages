$ErrorActionPreference = 'Stop'
$exeName = "MediaCreationTool.exe"

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  PackageName  = $env:chocolateyinstall
  FileFullPath = "$toolsDir\$exeName"
  Url          = 'https://software-download.microsoft.com/download/pr/MediaCreationTool1803.exe'
  Checksum     = '8960B2C95DB3A09AE2D7ABF820EA45E7100959F20CCD7EDCCA9EC5028D684B28DE3AC6ECDAE834150D40B91C1C264AD29BC2288D388B528B970C0F7531ACF909'
  ChecksumType = 'sha512'
}
Get-ChocolateyWebFile @packageArgs

Register-Application "$toolsDir\$exeName"
