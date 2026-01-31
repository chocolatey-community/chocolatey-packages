$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'MSI'
  url64          = 'https://download.calibre-ebook.com/9.1.0/calibre-64bit-9.1.0.msi'
  checksum64     = '7bef9101b1398a07274742e4cfb3aa7a7bfd60049c00641c6fa4610ec931b017'
  checksumType64 = 'sha256'
  softwareName   = 'calibre*'
  silentArgs     = '/quiet'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
