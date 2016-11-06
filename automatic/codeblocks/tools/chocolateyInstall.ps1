$ErrorActionPreference = 'Stop'

$fosshubUrl = 'https://www.fosshub.com/Code-Blocks.html/codeblocks-16.01mingw-setup.exe'

$packageArgs = @{
  packageName    = 'codeblocks'
  fileType       = 'exe'
  softwareName   = 'CodeBlocks'

  checksum       = '4d1b66c02ea6be91912b3f9cd67a1c3a7933b7e2dd062db00344faf39e3cae1c'
  checksumType   = 'sha256'
  url            = Get-UrlFromFosshub $fosshubUrl

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
