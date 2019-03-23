$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.42.1-Windows/maxima-clisp-sbcl-5.42.1-win32.exe/download'
  url64bit       = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.42.1-Windows/maxima-clisp-sbcl-5.42.1-win64.exe/download'
  softwareName   = 'maxima*'
  checksum       = '3C23BBEC850BCB998C09BC73A518871A32C88991C14E8F68FB95A4AE080A92C8'
  checksumType   = 'sha256'
  checksum64     = 'D4F14E263C21CE6518CD04C5A6AC9C99335FCE8756E2FD2DB6B6CB15A8C00576'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
