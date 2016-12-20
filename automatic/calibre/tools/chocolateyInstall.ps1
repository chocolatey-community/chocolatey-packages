$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'calibre'
  fileType       = 'MSI'
  url            = 'https://download.calibre-ebook.com/2.73.0/calibre-2.73.0.msi'
  url64Bit       = 'https://download.calibre-ebook.com/2.73.0/calibre-64bit-2.73.0.msi'
  checksum       = 'f68e32f963c75f4f2dfa8a1895d5ff9d891c5ff2e3e6cd75a158f8636f8c2e5f'
  checksum64     = 'f575c5329f3be94a22612b3719e668bdec014c4dfd4b78fad61896aa94464565'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
