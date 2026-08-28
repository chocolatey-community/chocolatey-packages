$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'MSI'
  url64          = 'https://download.calibre-ebook.com/9.14.0/calibre-64bit-9.14.0.msi'
  checksum64     = '4ccaf2a49a0069b5e78291ee7248dcd8967896d316d6432ddf657b6feae8f32d'
  checksumType64 = 'sha256'
  softwareName   = 'calibre*'
  silentArgs     = '/quiet'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
