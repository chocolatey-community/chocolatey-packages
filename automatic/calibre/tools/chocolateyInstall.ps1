$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'MSI'
  url64          = 'https://download.calibre-ebook.com/7.24.0/calibre-64bit-7.24.0.msi'
  checksum64     = 'f51bb4a90fe1b031bea35f00c0a3fc4c5f35c9dd97f3e9faff043a932a9e02d4'
  checksumType64 = 'sha256'
  softwareName   = 'calibre*'
  silentArgs     = '/quiet'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
