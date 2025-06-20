$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'MSI'
  url64          = 'https://download.calibre-ebook.com/8.5.0/calibre-64bit-8.5.0.msi'
  checksum64     = 'e9789c7b3a0f9a7e4d0712c802f14e3ec528ac12d49781690872a6b9c16f3a54'
  checksumType64 = 'sha256'
  softwareName   = 'calibre*'
  silentArgs     = '/quiet'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
