$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'calibre'
  fileType       = 'MSI'
  url            = 'https://download.calibre-ebook.com/2.69.0/calibre-2.69.0.msi'
  url64Bit       = 'https://download.calibre-ebook.com/2.69.0/calibre-64bit-2.69.0.msi'
  checksum       = 'a35c36c065be4ae4796c01676722a45af19c6e2db864fbcc2b6c0f36c9887bf6'
  checksum64     = '46d02d6866f8d2e2630a131589cf9cd5258a7d1e5b1554aa1aaad2fae1cb6083'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
