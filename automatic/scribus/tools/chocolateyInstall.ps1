$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'scribus'
  url            = 'https://sourceforge.net/projects/scribus/files/scribus/1.4.6/scribus-1.4.6-windows.exe/download'
  url64          = 'https://sourceforge.net/projects/scribus/files/scribus/1.4.6/scribus-1.4.6-windows-x64.exe/download'
  checksum       = '7a3c24985d397fc149fb1b4852bb6bb911722c8b2ed44b04e350059a93ed5f4b'
  checksum64     = '267853dadfbf97309f4fe780fc8da5b2807739a473ae1e58b0c90c5ee6ea2212'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  softwareName   = 'Scribus*'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
