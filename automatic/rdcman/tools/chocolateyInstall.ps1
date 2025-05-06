$installDir = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'rdcman'
  url            = 'https://download.sysinternals.com/files/RDCMan.zip'
  checksum       = 'b4f123042b8fe1c39fd90c2cc777291d9a2fe1c517a05138b8081b3c8603a983'
  checksumType   = 'sha256'
  unzipLocation  = $installDir
}
Install-ChocolateyZipPackage @packageArgs
