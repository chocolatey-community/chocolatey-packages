$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.15.9/wesnoth-1.15.9-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '755a031e1cbfd7b096d58e838fb90e610590865e17a3fcf2761dd8bfd6e89a4c'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
