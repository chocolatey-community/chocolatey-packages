$installDir = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'rdcman'
  url            = ''
  checksum       = ''
  checksumType   = ''
  unzipLocation  = $installDir
}
Install-ChocolateyZipPackage @packageArgs
