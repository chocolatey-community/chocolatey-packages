$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'calibre'
  fileType       = 'MSI'
  url            = 'https://download.calibre-ebook.com/2.79.1/calibre-2.79.1.msi'
  url64Bit       = 'https://download.calibre-ebook.com/2.79.1/calibre-64bit-2.79.1.msi'
  checksum       = '6e94611d265a8ea52c4e992dd6558e495504ac9ead899cd22a4f77cdc7b807f6'
  checksum64     = 'f435fe1ccee81115085de4800cf0f2f136a40200d8508e0650f873e75202701f'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
