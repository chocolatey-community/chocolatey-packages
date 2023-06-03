$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.47.0-Windows/maxima-5.47.0-win32.exe/download'
  url64bit       = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.47.0-Windows/maxima-5.47.0-win64.exe/download'
  softwareName   = 'maxima*'
  checksum       = 'd00d1bedaa6364ffdbb01b4af5a0a217ed4a0d9d75c43156747b5da2d233fc76'
  checksumType   = 'sha256'
  checksum64     = 'e0a5cb667f11bbef6d3b9cd444fdcb4ed464fe2a2933185d115e2567635af20c'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
