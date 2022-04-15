$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.46.0-Windows/maxima-5.46.0-win32.exe/download'
  url64bit       = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.46.0-Windows/maxima-5.46.0-win64.exe/download'
  softwareName   = 'maxima*'
  checksum       = 'a57d91429a8da5741ab170c130137a93cd8431b8efdf13e7da774808601fe3e4'
  checksumType   = 'sha256'
  checksum64     = '93a877a51193f3987b3ec49daa6f231adbcdfc146ba3a7b07e7c284c29aca3c5'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
