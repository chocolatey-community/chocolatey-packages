$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'calibre'
  fileType       = 'MSI'
  url            = 'https://download.calibre-ebook.com/2.66.0/calibre-2.66.0.msi'
  url64Bit       = 'https://download.calibre-ebook.com/2.66.0/calibre-64bit-2.66.0.msi'
  checksum       = '60ED837C7334AC03B5E5071A7D36F5FDB03BE6BFEDA7914DDC4133722251057F'
  checksum64     = '35334A07A372939C3280F58DEC62013452DB17D3587D8D5DF2CFCEF727863201'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
