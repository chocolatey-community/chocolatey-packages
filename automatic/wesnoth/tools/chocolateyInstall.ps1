$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.18/wesnoth-1.18.5/wesnoth-1.18.5-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '915d9c0374221782fbfaecd3ac8d8833b470c6ed6c059e6086d5082a28edf80f'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
