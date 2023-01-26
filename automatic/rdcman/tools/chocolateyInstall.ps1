$installDir = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'rdcman'
  url            = 'https://download.sysinternals.com/files/RDCMan.zip'
  checksum       = 'df183e730ece0ca8946f04be5456fd63a9088b1bb9a463bf155926a4908956b3'
  checksumType   = 'sha256'
  unzipLocation  = $installDir
}
Install-ChocolateyZipPackage @packageArgs
