$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'MSI'
  url64          = 'https://download.calibre-ebook.com/8.9.0/calibre-64bit-8.9.0.msi'
  checksum64     = '67b5346d302bdca7480b620a74438680d4b85499a8757cbc0e0ed0155fbb8357'
  checksumType64 = 'sha256'
  softwareName   = 'calibre*'
  silentArgs     = '/quiet'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
