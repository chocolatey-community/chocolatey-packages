$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'calibre'
  fileType       = 'MSI'
  url            = 'https://download.calibre-ebook.com/2.75.1/calibre-2.75.1.msi'
  url64Bit       = 'https://download.calibre-ebook.com/2.75.1/calibre-64bit-2.75.1.msi'
  checksum       = '8dc39b139c82081259f66e2561a8bbb7c95973dd0345fae32f939536ee131139'
  checksum64     = 'f54c4304e3b237530476991ac7bad4e7119004e79613478ce7a4f14380bc16c1'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
