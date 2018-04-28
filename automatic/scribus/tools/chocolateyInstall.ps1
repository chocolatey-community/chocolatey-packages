$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'scribus'
  url            = 'https://sourceforge.net/projects/scribus/files/scribus/1.4.7/scribus-1.4.7-windows.exe/download'
  url64          = 'https://sourceforge.net/projects/scribus/files/scribus/1.4.7/scribus-1.4.7-windows-x64.exe/download'
  checksum       = 'fc8737d1dbf88dadd376a7e394fd2f02065617a1d84a585e18d51caacad43c59'
  checksum64     = 'cadffc225b50375a7d1ddc8e46dbf3fe6e2e95d03ebb682bee1c230d6cb7532e'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  softwareName   = 'Scribus*'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
